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
  revision 'main'
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

execute "go install github.com/x-motemen/ghq@latest" do
  creates "#{home}/go/bin/ghq"
end

execute "go install github.com/go-delve/delve/cmd/dlv@latest" do
  creates "#{home}/go/bin/dlv"
end

execute "go install golang.org/x/tools/gopls@latest" do
  creates "#{home}/go/bin/gopls"
end

# aws cli
remote_file "#{Chef::Config[:file_cache_path]}/awscliv2.zip" do
  source 'https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip'
  not_if "[ -d #{home}/aws-cli/v2 ]"
  ## archive_file is supported in Chef 15 or newer
  notifies :extract, 'archive_file[awscliv2]', :immediately
end

archive_file 'awscliv2' do
  destination "#{Chef::Config[:file_cache_path]}/awscliv2"
  path "#{Chef::Config[:file_cache_path]}/awscliv2.zip"
  action :nothing
  notifies :run, 'bash[install_awscliv2]', :immediately
end

bash "install_awscliv2" do
  cwd "#{Chef::Config[:file_cache_path]}/awscliv2"
  code "./aws/install --install-dir #{home}/aws-cli --bin-dir #{home}/.local/bin"
  action :nothing
end

# kubectl
stable_ver = `curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`
remote_file "#{home}/.local/bin/kubectl" do
  source "https://storage.googleapis.com/kubernetes-release/release/#{stable_ver}/bin/linux/amd64/kubectl"
  user name
  group name
  mode '755'
end

execute 'curl https://sdk.cloud.google.com | bash' do
  creates "#{home}/google-cloud-sdk/bin/gcloud"
end

# other repos
## https://github.com/ahmetb/kubectx
### ghq get ahmetb/kubectx
## https://github.com/aluxian/fish-kube-prompt
### ghq get aluxian/fish-kube-prompt
