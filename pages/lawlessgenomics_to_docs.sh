#!/bin/bash

output=~/web/swisspedhealth_pipedev/docs/pages
input=~/web/DylanLawless.github.io/_topic/statistics


for file in $input/altman_bland_*
do
    # Define the destination file path
    dest_file="$output/$(basename $file)"

# Use sed to transform the file content as required and save it to the new location
sed -e 's/layout: topic/layout: default/' \
-e 's/{{ site.baseurl }}{% link \(.*\) %}"/{{ "assets\/\1"/' \
-e 's/" width="100%">/" | relative_url }}" width="100%">/' \
-e '1a\
nav_order: 5' \
-e '1a\
math: mathjax' \
-e '/tags:/d' \
-e '/status:/d' \
-e 's/title:/title: Stats/g' \
-e '/subject:/d' \
-e '/{% bibliography --cited %}/d' \
-e 's/link images\//link assets\/images\//g' \
-e 's/{% cite \([^%]*\) %}/\1/g' \
$file > $dest_file
done

cp ~/web/DylanLawless.github.io/images/altman*  ~/web/swisspedhealth_pipedev/docs/assets/images/
cp ~/web/DylanLawless.github.io/images/receiver_operating_*  ~/web/swisspedhealth_pipedev/docs/assets/images/
