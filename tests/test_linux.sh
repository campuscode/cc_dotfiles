#!/bin/bash
# Test cc_dotfiles installation on Linux/Ubuntu using Multipass
#
# Requires: Multipass (https://multipass.run)
#   sudo snap install multipass
#
# Usage:
#   ./tests/test_linux.sh            # create VM and install dotfiles
#   ./tests/test_linux.sh teardown   # destroy the VM
#   multipass shell cc-dotfiles      # access the VM

set -eu

VM_NAME="cc-dotfiles"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

teardown() {
  multipass delete "$VM_NAME" --purge
  echo "VM '$VM_NAME' destroyed."
}

if [ "${1:-}" = "teardown" ]; then
  teardown
  exit 0
fi

# Recreate VM from scratch
if multipass list | grep -q "$VM_NAME"; then
  teardown
fi

multipass launch 24.04 --name "$VM_NAME" --mount "$PROJECT_DIR":/home/ubuntu/cc_dotfiles

# Install curl (only prerequisite not in base image)
multipass exec "$VM_NAME" -- sudo apt-get update
multipass exec "$VM_NAME" -- sudo apt-get install -y curl

# Install dotfiles using the mounted project directory
multipass exec "$VM_NAME" -- bash -c 'cd ~/cc_dotfiles && LOCAL_INSTALL=1 bash install.sh'

echo ""
echo "Done! Access the VM with: multipass shell $VM_NAME"
echo "Project mounted at: /home/ubuntu/cc_dotfiles"
