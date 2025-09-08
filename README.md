# dsb-infra

Terraform for the perf-lab cluster that runs the DeathStarBench suites (socialNetwork, hotelReservation, mediaMicroservices) for load and autoscaling experiments.

- `terraform/`: VPC, EKS cluster `perf-lab-use1`, AWS Load Balancer Controller role, DNS record in the corporate private zone, wrk2 runner role
- `terraform/envs/`: per-environment variable files. `perf` is applied by CI. `dev` is not provisioned yet.

Workloads are deployed by Flux from `jsboak/dsb-gitops`. Flux was bootstrapped by hand after the cluster came up:

    flux bootstrap github --owner=jsboak --repository=dsb-gitops --branch=main --path=clusters/perf-lab-use1 --personal

Changes under `terraform/` are planned on pull requests and applied on merge to `main`. The wrk2 results bucket is owned by the data team and is only referenced here.

## Access

The cluster API endpoint is public and uses IAM authentication. Add yourself to `access_entries` in `terraform/eks.tf` if you need `kubectl` access.
