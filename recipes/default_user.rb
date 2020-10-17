name = ENV['SUDO_USER'] || ENV['LOGNAME']
home = ENV['HOME']
rbenvdir = "#{home}/.rbenv"
nodenvdir = "#{home}/.nodenv"

execute "dots/setup.sh" do
 command File.expand_path(".dots/setup.sh", home)
 user name
 action :nothing
end

git File.expand_path(".dots", home) do
 repository "https://github.com/komazarari/dots.git"
# notifies :run, "execute[dots/setup.sh]"
 revision 'master'
 user name
 group name
end

git File.expand_path(".emacs.d", home) do
  repository "https://github.com/komazarari/.emacs.d.git"
  revision 'master'
  user name
  group name
end

directory "#{home}/.config" do
  owner name
  group name
end

git File.expand_path(".config/fish", home) do
  repository "https://github.com/komazarari/fish.git"
  revision 'master'
  user name
  group name
end

git rbenvdir do
  repository "https://github.com/sstephenson/rbenv.git"
  revision 'master'
  user name
  group name
end

directory "#{rbenvdir}/plugins" do
  owner name
  group name
end

git "#{rbenvdir}/plugins/ruby-build" do
  repository "https://github.com/sstephenson/ruby-build.git"
  revision 'master'
  user name
  group name
end

git nodenvdir do
  repository "https://github.com/nodenv/nodenv.git"
  revision 'master'
  user name
  group name
end
execute "cd #{nodenvdir} && src/configure && make -C src"

directory "#{nodenvdir}/plugins" do
  owner name
  group name
end

git "#{nodenvdir}/plugins/node-build" do
  repository "https://github.com/nodenv/node-build.git"
  revision 'master'
  user name
  group name
end

directory "#{home}/.ssh" do
  user name
  group name
  mode '700'
end

directory "#{home}/.local" do
  user name
  group name
  mode '755'
end

directory "#{home}/.local/bin" do
  user name
  group name
  mode '755'
end

execute "go get github.com/motemen/ghq" do
  creates "#{home}/go/bin/ghq"
end

execute "go get github.com/go-delve/delve/cmd/dlv" do
  creates "#{home}/go/bin/dlv"
end

execute "go get github.com/stamblerre/gocode" do
  creates "#{home}/go/bin/gocode"
end

execute "go get github.com/rogpeppe/godef" do
  creates "#{home}/go/bin/godef"
end

execute "go get golang.org/x/tools/gopls" do
  creates "#{home}/go/bin/gopls"
end

# other repos
## https://github.com/ahmetb/kubectx
### ghq get ahmetb/kubectx
## https://github.com/aluxian/fish-kube-prompt
### ghq get aluxian/fish-kube-prompt
