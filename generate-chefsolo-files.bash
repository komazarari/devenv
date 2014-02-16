#!/bin/bash

mydir_path=`dirname \`readlink -f $0\``
cookbooks_path=`dirname $mydir_path`
symlink_path=${cookbooks_path}/dev

echo "generate solo.rb ..."
{
    echo "log_level :debug"
    echo "file_cache_path \"/var/tmp/chef-solo\""
    echo "cookbook_path [\"$cookbooks_path\"]"
} > solo.rb

echo "generate node.json ..."
{
    echo "{"
    echo "  \"dev\": { \"user\": \"`whoami`\" },"

    echo "  \"run_list\": [\"recipe[dev]\"]"
    echo "}"
} > node.json

echo "generate symlink ..."
if [ ! -L $symlink_path ]; then
    ln -s $mydir_path $symlink_path
fi

echo "
 Now you are ready to run:
 > sudo chef-solo -c ./solo.rb -j node.json"
