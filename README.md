# dev recipe

WSL Ubuntu 上の環境を構築するための recipe

# Requirements
chef client

    curl -L https://omnitruck.chef.io/install.sh | sudo bash

# Usage

    sudo -E chef-apply ./recipes/default.rb --why-run
    sudo -E chef-apply ./recipes/default.rb

    sudo -E chef-apply ./recipes/wsl.rb
    sudo -E chef-apply ./recipes/fish.rb

then

    chsh -s /usr/bin/fish

and logout && re-login

    # without sudo
    chef-apply ./recipes/post_chsh.rb --why-run
    chef-apply ./recipes/post_chsh.rb
