#!/bin/bash

echo package
echo git
echo vim

test -r ./local/install-order.sh && ./local/install-order.sh
