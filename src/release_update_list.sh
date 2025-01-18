#!/bin/bash

for file in ../pages/*.md; do
	echo "$(grep 'Last update' "$file") - $file"
done | sort -t: -k3,3r > release_update_list_out




