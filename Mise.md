# Mise

[mise](https://mise.jdx.dev) is a polyglot runtime manager (Ruby, Node.js, Python, Go, and more). It replaces tools like rbenv, nvm, and pyenv with a single CLI.

## Common commands

| Command | Action |
|---|---|
| `mise use --global ruby@3.3` | Set global Ruby version to 3.3 |
| `mise use ruby@3.2` | Set Ruby 3.2 for the current project (creates `.mise.toml`) |
| `mise use --global node@22` | Set global Node.js version to 22 |
| `mise install ruby node` | Install the configured versions |
| `mise current` | Show active tool versions |
| `mise ls` | List all installed versions |
| `mise ls-remote ruby` | List available Ruby versions |
| `mise upgrade ruby` | Upgrade Ruby to the latest compatible version |
| `mise prune` | Remove unused versions to free disk space |

## Per-project versions

Create a `.mise.toml` in your project root to pin versions:

```toml
[tools]
ruby = "3.3"
node = "22"
```

Mise picks this up automatically when you `cd` into the project directory.

## Adding more tools

Mise supports many tools beyond Ruby and Node.js:

```bash
mise use --global python@3.12
mise use --global jq
mise use --global go@latest
```

See the full list with `mise registry` or at [mise.jdx.dev](https://mise.jdx.dev).
