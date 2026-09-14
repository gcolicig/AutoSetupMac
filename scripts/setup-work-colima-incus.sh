#!/usr/bin/env bash

set -euo pipefail

PROFILE="${COLIMA_INCUS_PROFILE:-work-incus}"
CPU="${COLIMA_INCUS_CPU:-6}"
MEMORY="${COLIMA_INCUS_MEMORY:-12}"
DISK="${COLIMA_INCUS_DISK:-120}"
MOUNT_ROOT="${COLIMA_INCUS_MOUNT:-$HOME/Code}"
POOL_SIZE="${COLIMA_INCUS_POOL_SIZE:-80GiB}"
POOL_NAME="${COLIMA_INCUS_POOL_NAME:-zfs-pool}"
NETWORK_NAME="${COLIMA_INCUS_NETWORK:-agentbr0}"
NETWORK_IPV4="${COLIMA_INCUS_NETWORK_IPV4:-10.68.110.1/24}"

need() {
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "Missing command: $1" >&2
		echo "Run ./bootstrap.sh or brew bundle first." >&2
		exit 1
	fi
}

need colima
need incus

if [[ ! -d "$MOUNT_ROOT" ]]; then
	echo "Mount root does not exist: $MOUNT_ROOT" >&2
	exit 1
fi

if ! colima list 2>/dev/null | awk 'NR > 1 {print $1}' | grep -qx "$PROFILE"; then
	echo "Creating Colima Incus profile: $PROFILE"
	colima start "$PROFILE" \
		--runtime incus \
		--cpu "$CPU" \
		--memory "$MEMORY" \
		--disk "$DISK" \
		--mount "$MOUNT_ROOT:w"
else
	echo "Starting existing Colima profile: $PROFILE"
	colima start "$PROFILE"
fi

echo "Checking Incus inside Colima profile..."
colima ssh -p "$PROFILE" -- incus version

echo "Preparing ZFS tooling and Incus baseline in Colima profile..."
colima ssh -p "$PROFILE" -- sudo apt-get update
colima ssh -p "$PROFILE" -- sudo apt-get install -y zfsutils-linux

if ! colima ssh -p "$PROFILE" -- incus storage show "$POOL_NAME" >/dev/null 2>&1; then
	colima ssh -p "$PROFILE" -- incus storage create "$POOL_NAME" zfs size="$POOL_SIZE"
fi

if ! colima ssh -p "$PROFILE" -- incus network show "$NETWORK_NAME" >/dev/null 2>&1; then
	colima ssh -p "$PROFILE" -- incus network create "$NETWORK_NAME" ipv4.address="$NETWORK_IPV4" ipv4.nat=true ipv6.address=none
fi

cat <<EOF
Work Colima/Incus profile is ready.

Profile:      $PROFILE
Runtime:      incus
Mount:        $MOUNT_ROOT -> Colima VM
Storage pool: $POOL_NAME
Network:      $NETWORK_NAME
IPv4:         $NETWORK_IPV4

Useful commands:
  colima ssh -p $PROFILE
  colima ssh -p $PROFILE -- incus list
  incus list

Note:
  If 'incus list' on macOS does not target this Colima profile automatically,
  use 'colima ssh -p $PROFILE -- incus ...' for now.
EOF
