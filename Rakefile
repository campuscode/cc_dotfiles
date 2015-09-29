require 'rake'

desc 'Install Campus Code Dotfile in your machine'
task :install do
  puts "Thank you for choose Campus Code Dotfiles (cc_dotfiles)"

  install_files(Dir.glob([
    "gemrc",
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

  install_vim_plugins

  install_zsh_syntax_highlighting

  change_shell
end

private

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

def run_command(cmd)
  puts "running #{cmd}"
  `#{cmd}`
end

def verify_pre_reqs

end
