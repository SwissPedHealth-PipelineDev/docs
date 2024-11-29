#!/bin/bash

# Define where the log will be saved
logbook=file_counts
logfile=$logbook/file_count_log.md

# Ensure the logbook directory exists
mkdir -p "$logbook"

# Count the number of Markdown files in the current directory
file_count=$(ls ../pages/*.md | wc -l)

# Format today's date in the format YYYYMMDD
date=$(date +"%Y%m%d")

# Log the file count and the date
echo "$date $file_count" >> $logfile

echo "Log entry added: $date with $file_count files"


