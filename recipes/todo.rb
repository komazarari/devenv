# ToDo !!!!!!
execute 'curl https://sdk.cloud.google.com | bash'
# execute 'pip3 install awscli --upgrade --user'
# execute 'curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl'
execute 'curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish'
execute '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
homebrew_tap 'aws/tap' do
  homebrew_path '/home/linuxbrew/.linuxbrew/bin/brew'
end
homebrew_package 'aws-sam-cli'

# other repos
## https://github.com/aluxian/fish-kube-prompt
### ghq get aluxian/fish-kube-prompt


# sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com "(lsb_release -cs)" main"
# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt_repository 'terraform' do
  arch 'amd64'
  components 'main'
  uri 'https://apt.releases.hashicorp.com'
  key 'https://apt.releases.hashicorp.com/gpg'
end
package 'terraform'
