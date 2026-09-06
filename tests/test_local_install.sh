#!/bin/bash
set -eu

case "${1:-}" in
  prepare)
    mkdir -p local
    printf 'repository zsh config\n' > local/zshrc.local
    printf 'repository custom config\n' > local/custom.local
    printf 'repository secret\n' > local/secrets
    printf 'repository plugins config\n' > local/plugins.vim.local
    printf 'repository zshenv config\n' > local/zshenv.local
    printf 'repository git config\n' > local/gitconfig.local
    printf 'existing home zsh config\n' > "$HOME/.zshrc.local"
    printf 'older zsh backup\n' > "$HOME/.zshrc.local.bkp"
    printf 'existing aliases config\n' > "$HOME/.aliases.local"
    printf 'external tmux config\n' > "$HOME/external-tmux.conf"
    ln -s "$HOME/external-tmux.conf" "$HOME/.tmux.conf.local"
    ln -s "$HOME/missing-plugins.vim" "$HOME/.plugins.vim.local"
    printf 'unlisted local config\n' > "$HOME/.custom.local"
    printf '[secret]\n  token = do-not-import\n' > "$HOME/.secrets"
    ln -s .secrets "$HOME/.zshenv.local"
    ln "$HOME/.secrets" "$HOME/.gitconfig.local"
    ;;
  verify)
    test -L "$HOME/.zshrc.local"
    test "$(readlink "$HOME/.zshrc.local")" = "$HOME/.cc_dotfiles/local/zshrc.local"
    test "$(cat "$HOME/.zshrc.local")" = 'existing home zsh config'
    test "$(cat "$HOME/.zshrc.local.bkp")" = 'older zsh backup'
    test "$(cat "$HOME/.zshrc.local.bkp.1")" = 'existing home zsh config'
    test "$(cat "$HOME/.cc_dotfiles/local/zshrc.local.bkp")" = 'repository zsh config'

    test -L "$HOME/.aliases.local"
    test "$(readlink "$HOME/.aliases.local")" = "$HOME/.cc_dotfiles/local/aliases.local"
    test "$(cat "$HOME/.aliases.local")" = 'existing aliases config'
    test "$(cat "$HOME/.aliases.local.bkp")" = 'existing aliases config'

    test -L "$HOME/.tmux.conf.local"
    test "$(cat "$HOME/.tmux.conf.local")" = 'external tmux config'
    test -L "$HOME/.tmux.conf.local.bkp"
    test "$(readlink "$HOME/.tmux.conf.local.bkp")" = "$HOME/external-tmux.conf"

    test -L "$HOME/.plugins.vim.local"
    test "$(readlink "$HOME/.plugins.vim.local")" = "$HOME/missing-plugins.vim"
    test "$(cat "$HOME/.cc_dotfiles/local/plugins.vim.local")" = 'repository plugins config'
    test ! -e "$HOME/.plugins.vim.local.bkp"
    test ! -L "$HOME/.plugins.vim.local.bkp"

    test "$(cat "$HOME/.custom.local")" = 'unlisted local config'
    test "$(cat "$HOME/.cc_dotfiles/local/custom.local")" = 'repository custom config'
    test "$(cat "$HOME/.secrets")" = "[secret]
  token = do-not-import"
    test "$(cat "$HOME/.cc_dotfiles/local/secrets")" = 'repository secret'
    test -L "$HOME/.zshenv.local"
    test "$(readlink "$HOME/.zshenv.local")" = .secrets
    test "$(cat "$HOME/.cc_dotfiles/local/zshenv.local")" = 'repository zshenv config'
    test ! -e "$HOME/.zshenv.local.bkp"
    test ! -L "$HOME/.zshenv.local.bkp"
    test "$HOME/.secrets" -ef "$HOME/.gitconfig.local"
    test "$(cat "$HOME/.cc_dotfiles/local/gitconfig.local")" = 'repository git config'
    test ! -e "$HOME/.gitconfig.local.bkp"
    test ! -L "$HOME/.gitconfig.local.bkp"

    test -L "$HOME/.vimrc.local"
    test "$(readlink "$HOME/.vimrc.local")" = "$HOME/.cc_dotfiles/local/vimrc.local"
    test -s "$HOME/.vimrc.local"

    if [ -z "${SKIP_REINSTALL:-}" ]; then
      rm "$HOME/.aliases.local"
      ln -s .cc_dotfiles/local/aliases.local "$HOME/.aliases.local"
      ln -s "$HOME/.cc_dotfiles" "$HOME/repo-alias"
      rm "$HOME/.zshrc.local"
      ln -s "$HOME/repo-alias/local/zshrc.local" "$HOME/.zshrc.local"
      cd "$HOME/.cc_dotfiles"
      CI=true rake install
      test ! -e "$HOME/.zshrc.local.bkp.2"
      test ! -e "$HOME/.aliases.local.bkp.1"
      test ! -e "$HOME/.tmux.conf.local.bkp.1"
    fi
    ;;
  copy-failure)
    test_root=$(mktemp -d)
    mkdir "$test_root/repo" "$test_root/home"
    cp Rakefile "$test_root/repo/Rakefile"
    mkdir "$test_root/repo/local"
    printf 'repository version\n' > "$test_root/repo/local/zshrc.local"
    printf 'home version\n' > "$test_root/home/.zshrc.local"

    (
      cd "$test_root/repo"
      HOME="$test_root/home" ruby -rrake <<'RUBY'
load 'Rakefile'

module FileUtils
  class << self
    def copy_file(*) = raise(IOError, 'forced copy failure')
  end
end

begin
  migrate_local_file(File.join(ENV.fetch('HOME'), '.zshrc.local'), 'local/zshrc.local')
  raise 'migration unexpectedly succeeded'
rescue IOError => error
  raise unless error.message == 'forced copy failure'
end

raise unless File.read('local/zshrc.local') == "repository version\n"
raise unless File.read(File.join(ENV.fetch('HOME'), '.zshrc.local')) == "home version\n"
raise if Dir.glob('local/zshrc.local.bkp*').any?
RUBY
    )
    ;;
  *)
    echo "Usage: $0 prepare|verify|copy-failure" >&2
    exit 2
    ;;
esac
