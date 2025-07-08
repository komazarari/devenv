
name = ENV['SUDO_USER'] || ENV['LOGNAME']
home = ENV['HOME']
# related links
link "#{home}/.local/bin/kubectx" do
  to "#{home}/src/github.com/ahmetb/kubectx/kubectx"
end
link "#{home}/.local/bin/kubens" do
  to "#{home}/src/github.com/ahmetb/kubectx/kubens"
end
