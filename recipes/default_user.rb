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
 notifies :run, "execute[dots/setup.sh]"
 checkout_branch 'master'
 user name
 group name
end

git File.expand_path(".emacs.d", home) do
  repository "https://github.com/komazarari/.emacs.d.git"
  checkout_branch 'master'
  user name
  group name
end


git rbenvdir do
  repository "https://github.com/sstephenson/rbenv.git"
  user name
  group name
end

directory "#{rbenvdir}/plugins" do
  owner name
  group name
end

git "#{rbenvdir}/plugins/ruby-build" do
  repository "https://github.com/sstephenson/ruby-build.git"
  user name
  group name
end

git nodenvdir do
  repository "https://github.com/nodenv/nodenv.git"
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
  user name
  group name
end

git "#{home}/.fzf" do
  repository "https://github.com/junegunn/fzf.git"
  user name
  group name
  notifies :run, "execute[#{home}/.fzf/install]"
end

execute "#{home}/.fzf/install" do
  action :nothing
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
