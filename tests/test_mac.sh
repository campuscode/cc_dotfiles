#!/bin/bash
# Test cc_dotfiles installation on macOS using UTM
#
# Requires: UTM (https://mac.getutm.app) with utmctl CLI
#   brew install --cask utm
#
# Before first run, create an Ubuntu Desktop 24.04 VM in UTM named "cc-dotfiles".
# Enable directory sharing in VM settings pointing to this project's parent directory.
#
# Usage:
#   ./tests/test_mac.sh            # start VM and install dotfiles
#   ./tests/test_mac.sh teardown   # stop the VM

set -eu

VM_NAME="cc-dotfiles"

teardown() {
  utmctl stop "$VM_NAME"
  echo "VM '$VM_NAME' stopped."
}

if [ "${1:-}" = "teardown" ]; then
  teardown
  exit 0
fi

# Start the VM if not already running
if ! utmctl status "$VM_NAME" | grep -q "started"; then
  utmctl start "$VM_NAME"
  echo "Waiting for VM to boot..."
  sleep 30
fi

echo ""
echo "VM '$VM_NAME' is running."
echo "Open UTM to access the graphical desktop."
echo ""
echo "Inside the VM, run:"
echo "  cd /path/to/shared/cc_dotfiles && LOCAL_INSTALL=1 sh install.sh"
