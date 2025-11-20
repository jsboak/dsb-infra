resource "aws_accessanalyzer_analyzer" "account" {
  analyzer_name = "${var.cluster_name}-account"
  type          = "ACCOUNT"
}

# The private zone perf.corp.internal is owned by the corporate DNS team and is
# already associated with this VPC.
data "aws_route53_zone" "perf" {
  name         = "perf.corp.internal"
  private_zone = true
}

# The internal ALB is created by the AWS Load Balancer Controller from the
# socialnetwork/nginx-thrift Ingress in dsb-gitops.
data "aws_lb" "social" {
  tags = {
    "ingress.k8s.aws/stack" = "socialnetwork/nginx-thrift"
  }
}

resource "aws_route53_record" "social" {
  zone_id = data.aws_route53_zone.perf.zone_id
  name    = "social.perf.corp.internal"
  type    = "A"

  alias {
    name                   = data.aws_lb.social.dns_name
    zone_id                = data.aws_lb.social.zone_id
    evaluate_target_health = true
  }
}

# Temporary: lets us hit NodePorts from laptops on the VPN while debugging wrk2 runs.
# TODO remove once the runs move fully into the loadtest namespace.
resource "aws_security_group_rule" "nodeport_lab" {
  type              = "ingress"
  description       = "wrk2 from laptops on the VPN (temporary)"
  security_group_id = module.eks.node_security_group_id
  from_port         = 30000
  to_port           = 32767
  protocol          = "tcp"
  cidr_blocks       = [var.corp_vpn_cidr]
}
