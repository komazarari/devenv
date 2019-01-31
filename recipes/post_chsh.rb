name = ENV['SUDO_USER'] || ENV['LOGNAME']

execute 'fish -c "fisher add decors/fish-ghq"'
execute 'fish -c "fisher add rafaelrinaldi/pure"'
execute 'fish -c "fisher add jethrokuan/z"'

execute 'go get github.com/motemem/ghq' do
  user name
  group name
  not_if "which ghq"
end

execute 'fish -c "set fish_user_paths $HOME/.local/bin $fish_user_paths"' do
  not_if { ENV['PATH'].include?('/.local/bin') }
end

execute 'fish -c "set fish_user_paths $HOME/.nodenv/bin $fish_user_paths"' do
  not_if { ENV['PATH'].include?('/.nodenv/bin') }
end

execute 'fish -c "set fish_user_paths $HOME/.rbenv/bin $fish_user_paths"' do
  not_if { ENV['PATH'].include?('/.rbenv/bin') }
end
