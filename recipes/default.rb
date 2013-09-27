#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

name = 'vagrant'
rbenvdir = "/home/#{name}/.rbenv"

%w(
git vim lv curl
autoconf binutils-doc build-essential flex libc6-dev automake
libtool libyaml-dev zlib1g-dev openssl libssl-dev
libreadline-dev libxml2-dev libxslt1-dev ncurses-dev
).each { |p| package p }

git rbenvdir do
  repository "https://github.com/sstephenson/rbenv.git"
  user name
  group name
end

directory "#{rbenvdir}/plugins" do
  owner name
  group name
  notifies :run, "bash[rbenv_init]"
end

git "#{rbenvdir}/plugins/ruby-build" do
  repository "https://github.com/sstephenson/ruby-build.git"
  user name
  group name
end

bash "rbenv_init" do
  code <<-EOC
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/#{name}/.profile
echo 'eval "$(rbenv init -)"' >> /home/#{name}/.profile
EOC
  user name
  group name
  action :nothing
end
