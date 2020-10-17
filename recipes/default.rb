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

package %w[
  git vim lv curl byobu
  build-essential make automake
  libtool zlib1g-dev openssl libssl-dev
  libreadline-dev libxml2-dev libxslt1-dev
  python3-pip
  apt-transport-https gnupg dirmngr ca-certificates software-properties-common
  ripgrep fzf
  keychain
]

package %w[
  language-pack-ja language-pack-gnome-ja
  cmigemo
]

package 'emacs'

#apt_repository 'docker' do
#  uri 'https://download.docker.com/linux/ubuntu'
#  arch 'amd64'
#  components ['stable']
#  distribution node['lsb']['codename']
#  key 'https://download.docker.com/linux/ubuntu/gpg'
#  action :add
#end
#package ['docker-ce-cli']

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
