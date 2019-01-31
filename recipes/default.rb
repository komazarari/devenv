#
# Cookbook Name:: devenv
# Recipe:: default
#
# Copyright (C) 2013-2019 Takuto Komazaki
#
# All rights reserved - Do Not Redistribute
#

#name = node['devenv']['user']
#home = node['devenv']['home']
name = ENV['SUDO_USER'] || ENV['LOGNAME']
home = ENV['HOME']
rbenvdir = "#{home}/.rbenv"
nodenvdir = "#{home}/.nodenv"

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
#package node['devenv']['emacs']
package 'emacs26'

apt_repository 'docker' do
  uri 'https://download.docker.com/linux/ubuntu'
  arch 'amd64'
  components ['stable']
  distribution node['lsb']['codename']
  key 'https://download.docker.com/linux/ubuntu/gpg'
  action :add
end
#package 'docker-ce'

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

git "${home}/.fzf" do
  repository "https://github.com/junegunn/fzf.git"
  user name
  group name
  notifies :run, 'execute[#{home}/.fzf/install]'
end

execute "#{home}/.fzf/install" do
  action :nothing
end

directory "#{home}/.ssh" do
  user name
  group name
  mode '700'
end

#bash "install npm packages" do
#  code <<-EOC
#npm install -g eslint babel-eslint eslint-plugin-react
#EOC
#end
