name = ENV['SUDO_USER'] || ENV['LOGNAME']

execute 'fish -c "fisher install decors/fish-ghq"'
#execute 'fish -c "fisher install rafaelrinaldi/pure"'
execute 'fish -c "fisher install jethrokuan/z"'
execute 'fish -c "fisher install evanlucas/fish-kubectl-completions"'

execute 'fish -c "set -U fish_user_paths $HOME/.local/bin $fish_user_paths"' do
  not_if { ENV['PATH'].include?('/.local/bin') }
end

execute 'fish -c "set -U fish_user_paths $HOME/.nodenv/bin $fish_user_paths"' do
  not_if { ENV['PATH'].include?('/.nodenv/bin') }
end

execute 'fish -c "set -U fish_user_paths $HOME/.rbenv/bin $fish_user_paths"' do
  not_if { ENV['PATH'].include?('/.rbenv/bin') }
end
