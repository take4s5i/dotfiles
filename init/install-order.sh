#!/bin/bash

echo package
echo git
echo vim

test -r $(dirname $0)/local/install-order.sh && bash $(dirname $0)/local/install-order.sh
