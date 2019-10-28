package ['docker-ce', 'docker-ce-cli', 'containerd.io']
package ['xauth']

execute 'install_ripgrep' do
  command "snap install ripgrep --classic"
  creates '/snap/bin/rg'
end
