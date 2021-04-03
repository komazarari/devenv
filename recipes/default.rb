#
# Cookbook Name:: devenv
# Recipe:: default
#
# Copyright (C) 2013-2019 Takuto Komazaki
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get update" do
  only_if { (Time.now - File::Stat.new('/var/cache/apt/pkgcache.bin').mtime) > 1500 }
end

directory Chef::Config[:file_cache_path] do
  mode '777' # for non-sudo user
end

package %w[
  git vim lv curl byobu jq
  build-essential make automake
  libtool zlib1g-dev openssl libssl-dev
  libreadline-dev libxml2-dev libxslt1-dev
  python3-pip
  apt-transport-https gnupg dirmngr ca-certificates software-properties-common
  fzf zip tree
  keychain direnv
  privoxy
]

package %w[bat ripgrep] do
  options '-o Dpkg::Options::="--force-overwrite"'
end

package %w[
  language-pack-ja language-pack-gnome-ja
  cmigemo
  fonts-firacode
]

apt_repository 'emacs-ppa' do
  uri 'ppa:kelleyk/emacs'
end
package "emacs27"
# package 'emacs'

#apt_repository 'docker' do
#  uri 'https://download.docker.com/linux/ubuntu'
#  arch 'amd64'
#  components ['stable']
#  distribution node['lsb']['codename']
#  key 'https://download.docker.com/linux/ubuntu/gpg'
#  action :add
#end
#package ['docker-ce-cli']

apt_repository 'hashicorp' do
  uri 'https://apt.releases.hashicorp.com'
  distribution node['lsb']['codename']
  components ['main']
  arch 'amd64'
  key 'https://apt.releases.hashicorp.com/gpg'
end
package "terraform"

apt_repository 'golang-backports' do
  uri 'ppa:longsleep/golang-backports'
end
package 'golang-1.15' do
  notifies :run, 'execute[install_golang]'
  notifies :run, 'execute[install_gofmt]'
end

# golang 1.15
execute 'install_golang' do
  command "update-alternatives --install /usr/local/bin/go golang /usr/lib/go-1.15/bin/go 10"
  creates '/usr/local/bin/go'
  action :nothing
end

execute 'install_gofmt' do
  command "update-alternatives --install /usr/local/bin/gofmt gofmt /usr/lib/go-1.15/bin/gofmt 10"
  creates '/usr/local/bin/gofmt'
  action :nothing
end

apt_repository 'fish' do
    uri 'ppa:fish-shell/release-3'
end
package 'fish'

remote_file "#{Chef::Config[:file_cache_path]}/session-manager-plugin.deb" do
  source 'https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb'
  not_if "dpkg -l session-manager-plugin"
  notifies :install, 'dpkg_package[session-manager-plugin]', :immediately
end
dpkg_package 'session-manager-plugin' do
  source "#{Chef::Config[:file_cache_path]}/session-manager-plugin.deb"
  action :nothing
end
