#!/usr/bin/env bash

# This script can convert udemy course outline into a markdown format
#
# Usage:
# - Open Chrom dev tools
# - Go to udemy course detail
# - Search for a course keyword, find the request, copy the response
# - run `pbpaste | ./parse-udemy-json.sh`

cat - | jq -r '.results |
    sort_by(.sort_order) | 
    reverse | 
    .[] | 
    if ._class == "chapter" then "- ## " + .title else "  - " + .title end
'
