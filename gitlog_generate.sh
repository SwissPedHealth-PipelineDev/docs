#!/bin/bash

# This script generates a git log from the specified year until January 31st of the following year.

echo "usage ./generate_gitlog.sh 2024"

# Check if a year is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <year>"
    exit 1
fi

# Assign the year to a variable
year=$1

# Calculate the next year
# next_year=$((year + 1))

# Define the date range
start_date="${year}-01-01"
end_date="${year}-12-31"

# Run git log command
git log --pretty=format:"%ad - %an: %s" --after="$start_date" --until="$end_date" > gitlog_${year}.txt

echo "Git log for ${year} saved to gitlog_${year}.txt"

# Count the number of lines in the log file
log_count=$(wc -l < gitlog_${year}.txt)

# Output the number of entries and save the log information
echo "\n\nGit log for ${year} contains $log_count entries and is saved to gitlog_${year}.txt" >> gitlog_${year}.txt
