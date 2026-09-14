# Work Mac Colima/Incus

This prepares a local work Mac Incus environment through Colima. It is intended
for the `macbook-work` Agent/COI role, not for stable Docker/App services.

## Installed Tools

The Brewfile installs:

- `colima`
- `incus`

Colima's upstream README documents Incus support through:

```sh
colima start --runtime incus
```

It also notes that Incus virtual machines require M3 or newer Apple Silicon.
System containers are still the expected first target for the work Mac.

## Setup

Run after `./bootstrap.sh` or `brew bundle`:

```sh
./scripts/setup-work-colima-incus.sh
```

Defaults:

```text
profile:      work-incus
cpu:          6
memory:       12 GiB
disk:         120 GiB
mount:        ~/Code
storage pool: zfs-pool
network:      agentbr0 (10.68.110.1/24)
```

Override with environment variables:

```sh
COLIMA_INCUS_CPU=4 COLIMA_INCUS_MEMORY=8 ./scripts/setup-work-colima-incus.sh
```

## Relationship to Incus Nuc

This setup aligns with the Incus Nuc conventions:

- `zfs-pool`
- `agentbr0`
- Agent/COI role only
- deferred ACL, UID/GID, and snapshot validation

When running the Incus Nuc Terraform/Ansible stack inside the Colima VM, use the
`macbook-work` site variant.
