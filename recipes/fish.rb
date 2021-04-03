apt_repository 'fish' do
  uri 'ppa:fish-shell/release-3'
end
package 'fish'

execute 'curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish'
