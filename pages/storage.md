---
layout: default
title: storage
nav_order: 5
---

# Storage
Last update: 20250120

## Summary

{: .note }

For a full omic analysis we estimate that 250GB of space is used per subject.

## Sample count


The number of subjects changes depending on the data type.
We have approximately 180 subjects currently.

## Data usage

* All project data
	- total: 45T
* Estimate per subject total data
	- All: 45000/180 = 250 GB per subject
* Current size prod raw data
	- WGS: 12.8T
	- RNA: 793.0G
* Estimate per subject raw data
	- WGS: 12800/180 = 70 GB per subject
	- RNA: 800/180 = 4.5 GB per subject

## All users data

```
`df -h /project/`

Filesystem Size Used Avail Use% Mounted on
tenant_name 77T 45T 32T 60% /project
```


## Raw prod data
### Size of WGS

```bash
du -sh prod/*/downloads/WGS* | awk '
    {
        # Convert all sizes to gigabytes for consistency
        size = $1
        sub(/[[:alpha:]]$/, "", size)
        unit = substr($1, length($1))
        if (unit == "T") size *= 1024
        if (unit == "G") size += 0
        total += size
    }
    END {
        if (total >= 1024) {
            printf "%.1fT\n", total / 1024
        } else {
            printf "%.1fG\n", total
        }
    }'
```


### Size of RNA

```bash
du -sh prod/*/downloads/RNA* | awk '
    {
        # Convert all sizes to gigabytes for consistency
        size = $1
        sub(/[[:alpha:]]$/, "", size)
        unit = substr($1, length($1))
        if (unit == "T") size *= 1024
        if (unit == "G") size += 0
        total += size
    }
    END {
        if (total >= 1024) {
            printf "%.1fT\n", total / 1024
        } else {
            printf "%.1fG\n", total
        }
    }'
```

## Size of individual batches

```
du -sh prod/*/downloads/WGS*
du -sh prod/*/downloads/RNA*
```
