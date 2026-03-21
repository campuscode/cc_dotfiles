# Testing cc_dotfiles

Test the dotfiles installation in an isolated VM before deploying to your machine.

## macOS (UTM)

Uses [UTM](https://mac.getutm.app) to run an Ubuntu Desktop VM with a graphical interface,
so you can visually verify the full installation (terminal colors, fonts, vim, tmux, etc).

### Setup (one-time)

1. Install UTM: `brew install --cask utm`
2. Download the [Ubuntu Desktop 24.04 ISO](https://ubuntu.com/download/desktop)
3. Create a new VM in UTM named `cc-dotfiles` using the ISO
4. In VM settings, enable directory sharing and point it to this repository

### Usage

```bash
./tests/test_mac.sh            # start the VM
./tests/test_mac.sh teardown   # stop the VM
```

Once the VM is running, open UTM and inside the VM terminal run:

```bash
cd /path/to/shared/cc_dotfiles && LOCAL_INSTALL=1 sh install.sh
```

## Linux/Ubuntu (Multipass)

Uses [Multipass](https://multipass.run) to run a headless Ubuntu VM with the project
directory mounted. Good for quick terminal-only testing.

### Setup (one-time)

```bash
sudo snap install multipass
```

### Usage

```bash
./tests/test_linux.sh            # create VM and install dotfiles
./tests/test_linux.sh teardown   # destroy the VM
multipass shell cc-dotfiles      # access the VM
```

The project is mounted at `/home/ubuntu/cc_dotfiles` inside the VM.
Edits on the host are immediately visible in the VM.

## Options

- `SKIP_DOCKER=1` — skip Docker installation (set in the VM before running install.sh)
