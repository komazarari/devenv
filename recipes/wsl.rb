package 'wslu'

file '/etc/wsl.conf' do
  content <<-EOF
[automount]
options = "metadata,umask=22,fmask=11"
[interop]
appendWindowsPath = false
[network]
generateResolvConf = false
EOF
end

directory '/mnt/c/tools/mozc' do
  recursive true
end

remote_file '/mnt/c/tools/mozc/mozc_emacs_helper.exe' do
  source 'https://github.com/smzht/mozc_emacs_helper/blob/master/mozc_emacs_helper.exe?raw=true'
  mode '755'
end

file '/usr/local/bin/mozc_emacs_helper.sh' do
  content <<-EOF
#!/bin/sh

cd /mnt/c/tools/mozc
./mozc_emacs_helper.exe "$@"
EOF
  mode '755'
end

link '/usr/share/fonts/windows' do
  to '/mnt/c/Windows/Fonts'
end
execute 'fc-cache -fv'

link '/usr/local/bin/xdg-open' do
  to '/usr/bin/wslview'
end
