require 'rake'

desc "Hook our dotfiles into system-standard positions."
task :install do
  linkables = Dir.glob('**/*{.symlink}', File::FNM_DOTMATCH)

  skip_all = false
  overwrite_all = false
  backup_all = false

  puts linkables
  linkables.each do |linkable|
    overwrite = false
    backup = false

    next if linkable.match(/\.git/) != nil

    file = linkable.split('/', 2).last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    puts target
    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    `ln -s "$PWD/#{linkable}" "#{target}"`
  end
  `touch $HOME/.python_history`
  `mkdir -p $HOME/bin`
  `git submodule update --init --recursive`
end
task :default => 'install'
