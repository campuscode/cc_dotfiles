require 'rake'

desc 'Install Campus Code Dotfile in your machine'
task :install do
  puts "Thank you for choose Campus Code Dotfiles (cc_dotfiles)"

  install_files(Dir.glob([
    "aliases",
    "aliases.local",
    "tmux.conf",
    "vimrc",
    "zsh",
    "zshenv",
    "zshrc",
    "zshrc.local",
    "bin",
    "vim",
    "plugins.vim.local",
    "vimrc.local",
    "git/*",
    "irb/*"
  ]))

  install_rvm

  install_prereqs

  install_fonts

  install_vim_plugins

  install_zsh_syntax_highlighting

  change_shell
end

private

def install_rvm
  puts "======================================================"
  puts "Installing rvm."
  puts "======================================================"
  system 'sudo apt-get install -y git gnupg build-essential'
  system 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
  system 'curl -sSL https://get.rvm.io | bash -s stable --ruby'
  system 'sudo usermod -a -G rvm `whoami`'
end

def install_vim_plugins
  system "vim -N \"+set hidden\" \"+syntax on\" +PlugInstall +qall"
end

def change_shell
  puts "You will change your default shell to zsh"
  run_command %{ chsh -s $(which zsh) }
end

def install_zsh_syntax_highlighting
  unless File.exists?("#{ENV["HOME"]}/.zsh-syntax-highlighting")
    run_command %{ git clone --depth=1 git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting }
  end
end

def install_files(files)
  files.each do |f|
    file_name = f.split('/').last
    source = "#{ENV["PWD"]}/#{f}"
    file = "#{ENV["HOME"]}/.#{file_name}"

    if File.exists?(file)
      puts "Moving #{file} to #{file}.bkp"
      run_command %{ mv #{file} #{file}.bkp }
    end

    run_command %{ ln -nfs "#{source}" "#{file}" }
  end
end

def install_fonts
  puts "======================================================"
  puts "Installing patched fonts for Powerline/Lightline."
  puts "======================================================"
  run_command %{ cp -f $HOME/.cc_dotfiles/fonts/* $HOME/Library/Fonts } if RUBY_PLATFORM.downcase.include?("darwin")
  run_command %{ mkdir -p ~/.fonts && cp ~/.cc_dotfiles/fonts/* ~/.fonts && fc-cache -vf ~/.fonts } if RUBY_PLATFORM.downcase.include?("linux")
  puts
end

def run_command(cmd)
  puts "running #{cmd}"
  system cmd
end

def macos?
  RUBY_PLATFORM.downcase.include?("darwin")
end

def linux?
  RUBY_PLATFORM.downcase.include?("linux")
end

def install_prereqs
  run_command %{ $HOME/.cc_dotfiles/mac.sh } if macos?
  run_command %{ $HOME/.cc_dotfiles/ubuntu.sh } if linux?
end

def verify_pre_reqs

end
