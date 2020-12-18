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
link "#{home}/.config/fish/functions/kube_ps.fish" do
  to "#{home}/src/github.com/komazarari/fish-kube-prompt/kube_ps.fish"
end
link "#{home}/.config/fish/functions/__kube_prompt.fish" do
  to "#{home}/src/github.com/komazarari/fish-kube-prompt/__kube_prompt.fish"
end
