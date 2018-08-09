# dev cookbook

local 環境を構築

# Requirements
chef client

```
curl -L https://omnitruck.chef.io/install.sh | sudo bash
```

# Usage

    mkdir -p cookbooks
    cd cookbooks
    git clone https://github.com/komazarari/devenv.git
    cd ../
    sudo chef-client -z -o devenv --why-run
    sudo chef-client -z -o devenv

# Attributes

# Recipes

# Author

Author:: YOUR_NAME (<YOUR_EMAIL>)
