#!/bin/sh

if [ -d "$1/$(basename $2)" ] ; then
  :
else
    git clone "https://$2.git" "$1/$(basename $2)"
fi
