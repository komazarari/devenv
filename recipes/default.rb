#
# Cookbook Name:: devenv
# Recipe:: default
#
# Copyright (C) 2013-2018 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

name = node['devenv']['user']
home = node['devenv']['home']
rbenvdir = "#{home}/.rbenv"

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
]
package packages

apt_repository 'emacs' do
  uri 'ppa:kelleyk/emacs'
end
package %w[
  language-pack-ja language-pack-gnome-ja
  cmigemo
]
package node['devenv']['emacs']

apt_repository 'docker' do
  uri 'https://download.docker.com/linux/ubuntu'
  arch 'amd64'
  components ['stable']
  distribution node['lsb']['codename']
  key 'https://download.docker.com/linux/ubuntu/gpg'
  action :add
end
package 'docker-ce'

execute "dots/setup.sh" do
  command File.expand_path(".dots/setup.sh", home)
  user name
  action :nothing
end

git File.expand_path(".dots", home) do
  repository "https://github.com/komazarari/dots.git"
  notifies :run, "execute[dots/setup.sh]"
  user name
end

git File.expand_path(".emacs.d", home) do
  repository "https://github.com/komazarari/.emacs.d.git"
  user name
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

execute 'node' do
  command "sudo curl -sL https://deb.nodesource.com/setup_#{node['devenv']['nodejs_major_version']}.x | sudo bash - && sudo apt-get install nodejs -y"
  creates '/usr/bin/node'
end

bash "install npm packages" do
  code <<-EOC
npm install -g eslint babel-eslint eslint-plugin-react
EOC
end
