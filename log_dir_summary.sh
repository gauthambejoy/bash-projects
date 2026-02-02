#!/bin/bash

for dir in /var/log/*; do
   if [[ -d $dir ]]; then
        name=$(basename "$dir")
        size=$(du -sh "$dir" | awk '{print $1}')
        permission=$(ls -ld "$dir" | awk '{print $1}')
        echo "NAME: $name"
        echo "SIZE: $size"
        echo "PERMISSION: $permission"
    fi
done