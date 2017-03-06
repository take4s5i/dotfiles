#!/bin/bash

echo package
echo git
echo vim

if [ -r ./local/install-order.sh ] ; then
    for p in $(./local/install-order.sh); do
        echo "local/${p}"
    done
fi
