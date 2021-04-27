# rancher

Rancher is a GUI for kubernetes, running on kubernetes-n vms.

## Setup

Create 5 new projects in Rancher:

- `Storage`
- `digit-secret`
- `digit-core`
- `digit`
- `digit-dev`

In the `Storage` project create a `Longhorn` app with default replicas set to number of kubernetes nodes, capped at 3.
