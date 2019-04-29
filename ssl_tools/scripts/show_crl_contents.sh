#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

wget -qO- $1
