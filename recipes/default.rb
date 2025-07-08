#
# Cookbook Name:: devenv
# Recipe:: default
#
# Copyright (C) 2013-2024 Takuto Komazaki
#
# All rights reserved - Do Not Redistribute
#

raise 'Unsupported Platform' unless node['platform'] == 'ubuntu'

execute "apt-get update" do
  only_if { (Time.now - File::Stat.new('/var/cache/apt/pkgcache.bin').mtime) > 1500 }
end

directory Chef::Config[:file_cache_path] do
  mode '777' # for non-sudo user
end

package %w[
  git vim lv curl byobu jq
  build-essential make automake
  libtool openssl
  apt-transport-https gnupg ca-certificates software-properties-common
  fzf zip tree shellcheck libnss3-tools
  keychain direnv
  privoxy
]

package %w[bat ripgrep]
package %w[git-lfs]

# ruby-build
package %w[
  libssl-dev
  libreadline-dev libxml2-dev libxslt1-dev libffi-dev libyaml-dev zlib1g-dev
]

#package %w[
#  language-pack-ja language-pack-gnome-ja
#  cmigemo
#  fonts-firacode
#]

case node['platform_version'].to_f
when 24.04..nil
  package 'emacs'
when 20.04...24.04
  apt_repository 'emacs-ppa' do
    uri 'ppa:kelleyk/emacs'
  end
  package "emacs28"
else
  raise 'Please update platform!'
end

apt_repository 'hashicorp' do
  uri 'https://apt.releases.hashicorp.com'
  distribution node['lsb']['codename']
  components ['main']
  arch 'amd64'
  key 'https://apt.releases.hashicorp.com/gpg'
end
package "terraform"

# aws session manager plugin
remote_file "#{Chef::Config[:file_cache_path]}/session-manager-plugin.deb" do
  source 'https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb'
  not_if "dpkg -l session-manager-plugin"
  notifies :install, 'dpkg_package[session-manager-plugin]', :immediately
end
dpkg_package 'session-manager-plugin' do
  source "#{Chef::Config[:file_cache_path]}/session-manager-plugin.deb"
  action :nothing
end

# golang
go_version = '1.22'
case node['platform_version'].to_f
when 24.04..nil
  package "golang-#{go_version}"
when 20.04...24.04
  apt_repository 'golang-backports' do
    uri 'ppa:longsleep/golang-backports'
  end
else
  raise 'Please update platform!'
end

package "golang-#{go_version}" do
  notifies :run, 'execute[install_golang]'
  notifies :run, 'execute[install_gofmt]'
end

execute 'install_golang' do
  command "update-alternatives --install /usr/local/bin/go golang /usr/lib/go-#{go_version}/bin/go 10"
  creates '/usr/local/bin/go'
  action :nothing
end

execute 'install_gofmt' do
  command "update-alternatives --install /usr/local/bin/gofmt gofmt /usr/lib/go-#{go_version}/bin/gofmt 10"
  creates '/usr/local/bin/gofmt'
  action :nothing
end
