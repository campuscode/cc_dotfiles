# Testing cc_dotfiles

Test the dotfiles installation in an isolated VM before deploying to your machine.

## macOS (Vagrant + UTM)

Uses [Vagrant](https://www.vagrantup.com) with the [vagrant_utm](https://github.com/naveenrajm7/vagrant_utm) plugin
to run an Ubuntu Desktop VM via UTM. Provides a graphical interface for visually verifying
terminal colors, fonts, vim, tmux, etc.

### Setup (one-time)

1. Install UTM and Vagrant:

```bash
brew install --cask utm
brew install --cask vagrant
```

2. Install the UTM provider plugin:

```bash
vagrant plugin install vagrant_utm
```

### Usage

```bash
vagrant up --provider=utm   # create VM, install dotfiles
vagrant ssh                 # access the VM via terminal
vagrant halt                # stop the VM
vagrant destroy -f          # destroy the VM
vagrant up --provision      # re-provision existing VM
```

After the first `vagrant up --provider=utm`, subsequent commands (`vagrant ssh`, `vagrant halt`, etc)
don't need the `--provider` flag.

To open the graphical desktop, use the UTM app — the VM will appear as `cc-dotfiles`.

The project directory is synced to `/vagrant` inside the VM.
Edits on the host are immediately visible in the VM.

### Verifying the installation

Inside the VM, verify:
- Open a new terminal — it should be running zsh with the peepcode theme
- Run `vim` — should open with gruvbox colorscheme and all plugins loaded
- Run `tmux` — prefix should be `C-a`, status bar should be styled
- Run `mise current` — should show Ruby and Node.js versions
- Run `git config --list` — should include the cc_dotfiles git aliases

### Starting over

```bash
vagrant destroy -f && vagrant up --provider=utm
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
