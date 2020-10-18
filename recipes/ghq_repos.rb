%w[
  https://github.com/ahmetb/kubectx
  https://github.com/komazarari/fish-kube-prompt
].each do |repo|
  execute "ghq get -u #{repo}"
end

name = ENV['SUDO_USER'] || ENV['LOGNAME']
home = ENV['HOME']
# related links
link "#{home}/.local/bin/kubectx" do
  to "#{home}/src/github.com/ahmetb/kubectx/kubectx"
end
link "#{home}/.local/bin/kubectx" do
  to "#{home}/src/github.com/ahmetb/kubectx/kubens"
end
# link "#{home}/.config/fish/" do
#   to "#{home}/src/github.com/komazarari/fish-kube-prompt"
# end
