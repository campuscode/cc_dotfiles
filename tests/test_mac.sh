#!/bin/bash
# Test cc_dotfiles installation on macOS using OrbStack
#
# Requires: OrbStack (https://orbstack.dev)
#
# OrbStack automatically mounts macOS home at the same path inside the VM,
# so edits on the host are immediately visible in the VM.
#
# Usage:
#   ./tests/test_mac.sh            # create VM and install dotfiles
#   ./tests/test_mac.sh teardown   # destroy the VM
#   orb shell cc-dotfiles          # access the VM

set -eu

VM_NAME="cc-dotfiles"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

teardown() {
  orb delete "$VM_NAME" -f
  echo "VM '$VM_NAME' destroyed."
}

if [ "${1:-}" = "teardown" ]; then
  teardown
  exit 0
fi

# Recreate VM from scratch
if orb list | grep -q "$VM_NAME"; then
  teardown
fi

orb create ubuntu:24.04 "$VM_NAME"

# Install curl (only prerequisite not in base image)
orb run -m "$VM_NAME" sudo apt-get update
orb run -m "$VM_NAME" sudo apt-get install -y curl

# Install dotfiles using the mounted project directory
orb run -m "$VM_NAME" bash -c "cd $PROJECT_DIR && LOCAL_INSTALL=1 sh install.sh"

echo ""
echo "Done! Access the VM with: orb shell $VM_NAME"
echo "Project mounted at: $PROJECT_DIR"
