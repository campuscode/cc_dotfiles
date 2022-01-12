require 'rake'

desc 'Install Campus Code Dotfile in your machine'
task :install do
  puts "Thank you for choose Campus Code Dotfiles (cc_dotfiles)"

  install_files(Dir.glob([
    "aliases",
    "tmux.conf",
    "vimrc",
    "zsh",
    "zshenv",
    "zshrc",
    "bin",
    "vim",
    "git/*",
    "irb/*"
  ]))

  install_prereqs
  install_fonts
  install_vim_plugins
  install_zsh_syntax_highlighting
  install_tmux_battery_plugin
  tmux_copy_mode
  add_vimrc_local
  change_shell
  installation_message
end

private

def cc_dotfiles_folder
  "$HOME/.cc_dotfiles"
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
    run_command %{ git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting }
  end
end

def tmux_copy_mode
  folder = cc_dotfiles_folder
  run_command %{ cp #{folder}/templates/copy_mode_mac.conf.tmp $HOME/.tmux_copy_mode.conf } if macos?
  run_command %{ cp #{folder}/templates/copy_mode_linux.conf.tmp $HOME/.tmux_copy_mode.conf } if linux?
end

def add_vimrc_local
  run_command %{ cp #{cc_dotfiles_folder}/templates/vimrc.local.tmp $HOME/.vimrc.local }
end

def install_tmux_battery_plugin
  folder = '.tmux-battery'
  unless File.exists?("#{ENV["HOME"]}/#{folder}")
    run_command %{ git clone --depth=1 https://github.com/tmux-plugins/tmux-battery $HOME/#{folder} }
    run_command %{ echo "run-shell $HOME/#{folder}/battery.tmux" >> $HOME/.tmux.conf.local }
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
  run_command %{ cp -f $HOME/.cc_dotfiles/fonts/* $HOME/Library/Fonts } if macos?
  run_command %{ mkdir -p ~/.fonts && cp ~/.cc_dotfiles/fonts/* ~/.fonts && fc-cache -vf ~/.fonts } if linux?
  puts
end

def run_command(cmd)
  puts "running #{cmd}"
  system cmd
rescue
  puts "Error running #{cmd}"
end

def macos?
  RUBY_PLATFORM.downcase.include?("darwin")
end

def linux?
  RUBY_PLATFORM.downcase.include?("linux")
end

def linux_message
  puts ''
  puts "- Change your terminal window to Run command as login shell and RESTART"
  puts ''
  puts "- You can find more information about this on \r
https://github.com/rvm/ubuntu_rvm"
end

def installation_message
  puts ''
  puts ''
  puts '======================================================================='
  puts 'Thank you!'
  puts ''
  puts ''
  linux_message if linux?
  puts '======================================================================='
end

def install_prereqs
  run_command %{ $HOME/.cc_dotfiles/mac.sh } if macos?
  run_command %{ $HOME/.cc_dotfiles/ubuntu.sh } if linux?
end
