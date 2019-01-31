# dev recipe

Ubuntu 上の local 環境を構築するための recipe

# Requirements
chef client

    curl -L https://omnitruck.chef.io/install.sh | sudo bash

# Usage

    sudo -E chef-apply ./recipes/default.rb --why-run
    sudo -E chef-apply ./recipes/default.rb
