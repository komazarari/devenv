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

packages = %w[
  git vim lv curl byobu
  build-essential make automake
  libtool zlib1g-dev openssl libssl-dev
  libreadline-dev libxml2-dev libxslt1-dev
  python3-pip
  apt-transport-https gnupg dirmngr ca-certificates software-properties-common
  golang
  keychain
]
package packages

apt_repository 'emacs' do
  uri 'ppa:kelleyk/emacs'
end
package %w[
  language-pack-ja language-pack-gnome-ja
  cmigemo
]
package 'emacs26'

apt_repository 'docker' do
  uri 'https://download.docker.com/linux/ubuntu'
  arch 'amd64'
  components ['stable']
  distribution node['lsb']['codename']
  key 'https://download.docker.com/linux/ubuntu/gpg'
  action :add
end
package ['docker-ce-cli']

