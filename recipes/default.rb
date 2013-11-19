#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

name = 'vagrant'
home = "/home/#{name}"
rbenvdir = "#{home}/.rbenv"

execute "apt-get update"

%w(
git vim lv curl byobu
autoconf binutils-doc build-essential flex libc6-dev automake
libtool libyaml-dev zlib1g-dev openssl libssl-dev
libreadline-dev libxml2-dev libxslt1-dev ncurses-dev
).each do |p|
  package p do
    options "--force-yes"
  end
end

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
