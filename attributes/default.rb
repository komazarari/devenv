default['devenv']['user'] = ENV['SUDO_USER'] || ENV['USER']
default['devenv']['home'] = ENV['HOME'] != /\A\/root/ ? ENV['HOME'] : "/home/#{node['devenv']['user']}"
default['devenv']['emacs'] = 'emacs26'
default['devenv']['nodejs_major_version'] = '10'
