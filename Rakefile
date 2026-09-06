require 'rake'
require 'fileutils'
require 'tempfile'

LOCAL_FILE_NAMES = %w[
  aliases.local
  zshrc.local
  zshenv.local
  vimrc.local
  plugins.vim.local
  tmux.conf.local
  gitconfig.local
].freeze

desc 'Install Campus Code Dotfile in your machine'
task :install do
  puts "Thank you for choose Campus Code Dotfiles (cc_dotfiles)"

  prepare_local_files

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
  install_local_files

  install_fonts
  install_vim_plugins
  install_zsh_syntax_highlighting
  install_tmux_battery_plugin
  tmux_copy_mode
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
  return if ENV['CI']
  puts "You will change your default shell to zsh"
  run_command %{ chsh -s $(which zsh) }
end

def install_zsh_syntax_highlighting
  unless File.exist?("#{ENV["HOME"]}/.zsh-syntax-highlighting")
    run_command %{ git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting }
  end
end

def tmux_copy_mode
  folder = cc_dotfiles_folder
  run_command %{ cp #{folder}/templates/copy_mode_mac.conf.tmp $HOME/.tmux_copy_mode.conf } if macos?
  run_command %{ cp #{folder}/templates/copy_mode_linux.conf.tmp $HOME/.tmux_copy_mode.conf } if linux?
end

def prepare_local_files
  FileUtils.mkdir_p('local')

  LOCAL_FILE_NAMES.each do |name|
    source = "local/#{name}"
    target = File.join(ENV['HOME'], ".#{name}")

    migrate_local_file(target, source)
  end

  vimrc_local = 'local/vimrc.local'
  FileUtils.cp('templates/vimrc.local.tmp', vimrc_local) unless File.exist?(vimrc_local)
end

def migrate_local_file(target, source)
  return unless File.exist?(target) || File.symlink?(target)
  return if managed_symlink?(target, File.expand_path(source, ENV['PWD']))

  if secrets_file?(target)
    puts "Skipping local file that resolves to #{File.join(ENV['HOME'], '.secrets')}: #{target}"
    return
  end

  if File.symlink?(target) && !File.exist?(target)
    puts "Skipping broken local symlink #{target}; its target cannot be copied"
    return
  end

  puts "Copying existing #{target} to #{source}"
  copy_local_file_safely(target, source)
end

def secrets_file?(path)
  secrets = File.join(ENV['HOME'], '.secrets')
  File.exist?(secrets) && File.identical?(path, secrets)
rescue Errno::ENOENT
  false
end

def copy_local_file_safely(target, source)
  source_backup = nil

  Tempfile.create([".#{File.basename(source)}", '.tmp'], File.dirname(source)) do |temporary|
    FileUtils.copy_file(target, temporary.path)
    unless FileUtils.compare_file(target, temporary.path)
      raise "Could not verify copied local file: #{target}"
    end

    if File.exist?(source) || File.symlink?(source)
      source_backup = available_backup_path(source)
      puts "Moving existing #{source} to #{source_backup}"
      FileUtils.mv(source, source_backup)
    end

    begin
      FileUtils.mv(temporary.path, source)
    rescue
      FileUtils.mv(source_backup, source) if source_backup && !File.exist?(source) && !File.symlink?(source)
      raise
    end
  end
end

def local_file_paths
  LOCAL_FILE_NAMES.map { |name| "local/#{name}" }.select do |path|
    File.file?(path) && !File.symlink?(path)
  end
end

def install_local_files
  local_file_paths.each do |source|
    target = File.join(ENV['HOME'], ".#{File.basename(source)}")

    if secrets_file?(target)
      puts "Leaving local file that resolves to #{File.join(ENV['HOME'], '.secrets')} unchanged: #{target}"
      next
    end

    if File.symlink?(target) && !File.exist?(target)
      puts "Leaving broken local symlink unchanged: #{target}"
      next
    end

    install_file(source, target)
  end
end

def install_tmux_battery_plugin
  folder = '.tmux-battery'
  path = "#{ENV["HOME"]}/#{folder}"
  if File.exist?(path)
    run_command %{ git -C #{path} pull }
  else
    run_command %{ git clone --depth=1 https://github.com/tmux-plugins/tmux-battery #{path} }
  end
end

def install_files(files)
  files.each do |f|
    file_name = f.split('/').last
    file = "#{ENV["HOME"]}/.#{file_name}"

    install_file(f, file)
  end
end

def install_file(source_path, file)
  source = File.expand_path(source_path, ENV['PWD'])

  return if managed_symlink?(file, source)

  if File.exist?(file) || File.symlink?(file)
    backup = available_backup_path(file)
    puts "Moving #{file} to #{backup}"
    FileUtils.mv(file, backup)
  end

  FileUtils.ln_sf(source, file)
end

def managed_symlink?(file, source)
  return false unless File.symlink?(file)

  linked_path = File.expand_path(File.readlink(file), File.dirname(file))
  return true if linked_path == source

  File.exist?(file) && File.exist?(source) && File.identical?(file, source)
rescue Errno::ENOENT
  false
end

def available_backup_path(file)
  backup = "#{file}.bkp"
  suffix = 0

  while File.exist?(backup) || File.symlink?(backup)
    suffix += 1
    backup = "#{file}.bkp.#{suffix}"
  end

  backup
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
end

def installation_message
  puts ''
  puts ''
  puts '======================================================================='
  puts 'Thank you!'
  puts ''
  puts ''
  puts "- Run 'mise install ruby node' to install latest versions" if linux?
  puts '======================================================================='
end
