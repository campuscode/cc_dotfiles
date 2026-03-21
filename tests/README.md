# Testing cc_dotfiles

Test the dotfiles installation in an isolated VM before deploying to your machine.

## macOS (UTM)

Uses [UTM](https://mac.getutm.app) to run an Ubuntu Desktop VM with a graphical interface,
so you can visually verify the full installation (terminal colors, fonts, vim, tmux, etc).

### Setup (one-time)

1. Install UTM:

```bash
brew install --cask utm
```

2. Download the [Ubuntu Desktop 24.04 ISO](https://ubuntu.com/download/desktop)

3. Create the VM in UTM:
   - Open UTM and click **Create a New Virtual Machine**
   - Select **Virtualize** (Apple Silicon) or **Emulate** (Intel)
   - Choose **Linux**
   - In **Boot ISO Image**, browse and select the Ubuntu 24.04 ISO
   - Recommended settings: 4GB RAM, 2+ CPU cores, 25GB disk
   - Finish the wizard and name the VM `cc-dotfiles`

4. Install Ubuntu inside the VM:
   - Start the VM and follow the Ubuntu Desktop installer
   - Choose a simple username/password (e.g., `dev`/`dev`)
   - Reboot when prompted (remove the ISO from the CD/DVD drive in UTM settings if it boots back into the installer)

5. Configure directory sharing:
   - Stop the VM
   - In UTM, select the VM and click **Edit** (gear icon)
   - Go to **Sharing**
   - Enable **Directory sharing** and set the path to this repository's directory
   - Start the VM again

6. Mount the shared folder inside the VM:

```bash
# Install spice tools for shared folders
sudo apt-get update
sudo apt-get install -y spice-vdagent spice-webdavd davfs2 curl

# Create mount point and mount
sudo mkdir -p /mnt/cc_dotfiles
sudo mount -t davfs http://localhost:9843 /mnt/cc_dotfiles
# When prompted for username/password, just press Enter for both
```

To auto-mount on boot, add to `/etc/fstab`:

```
http://localhost:9843 /mnt/cc_dotfiles davfs user,noauto 0 0
```

### Installing dotfiles

Inside the VM terminal:

```bash
cd /mnt/cc_dotfiles && LOCAL_INSTALL=1 sh install.sh
```

### Verifying the installation

Inside the VM, verify:
- Open a new terminal — it should be running zsh with the peepcode theme
- Run `vim` — should open with gruvbox colorscheme and all plugins loaded
- Run `tmux` — prefix should be `C-a`, status bar should be styled
- Run `mise current` — should show Ruby and Node.js versions
- Run `git config --list` — should include the cc_dotfiles git aliases

### Starting over

To test a clean install from scratch, you can either:
- Delete `~/.cc_dotfiles` inside the VM and re-run `install.sh`
- Or destroy the VM in UTM and recreate it from a snapshot

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
