#!/bin/bash

echo package
echo git
echo vim

test -r ./local/install-order.sh && bash ./local/install-order.sh
