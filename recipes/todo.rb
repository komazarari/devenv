# ToDo !!!!!!
execute 'curl https://sdk.cloud.google.com | bash'
execute 'pip3 install awscli --upgrade --user'
execute 'curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl'

execute 'curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish'


# SUDO
# execute 'sudo add-apt-repository ppa:longsleep/golang-backports'
# execute 'sudo apt install golang-1.13'
# execute 'sudo update-alternatives --install /usr/bin/go golang /usr/lib/go-1.13/bin/go 10'
# execute 'sudo update-alternatives --install /usr/bin/gofmt gofmg /usr/lib/go-1.13/bin/gofmt 10'

# other repos
## https://github.com/ahmetb/kubectx
### ghq get ahmetb/kubectx
## https://github.com/aluxian/fish-kube-prompt
### ghq get aluxian/fish-kube-prompt
