---
layout: default
title: Design release DNA SNV INDEL v1
parent: Design documents
has_children: false
nav_order: 5
---


Last update: 20250102

# Design release DNA SNV INDEL v1

---
* TOC
{:toc}
---

**Protocol name**: `design_dna_snv_indel_v1_relsease` (this document) for `design_dna_snvindel_v1` (see [design_dna_snvindel_v1](design_dna_snvindel_v1.html)).

### Data synchronisation process

1. Sync release data to `shared_all`.
1. Log and verify data during sync to `shared_all`.
1. Data manager syncs from `shared_all` to `shared`.
1. The final release is locked in `shared` but allows incremental additions.
1. Labelled as `release_dna_snv_indel_v1`.

### Data Availability

All raw and processed data are accessible to all internal researchers. 
Processed/intermediate data might change during projects, so released data is recommended for downstream projects. 
Release data should have detailed supporting documentation following the protocol. 
Essential data is curated to minimise storage use. 
Non-release data is accessible as usual from user directories but may be overwritten or updated without notice. 
Data paths are listed in the release script, generally read from a master list of variables.
### Current version script

`release_dna_snv_indel_v1.sh` is an example from the user src directory 

```
#!/bin/bash

# This is a script and log of data from
# Design_DNA_SNV_INDEL_v1 pipeline for
# Design_DNA_SNV_INDEL_v1_release
# This is the recommended data release for use other projects

# Note to data manager. Please do:
# rsync -avz -P /project/data/shared_all/release_dna_snv_indel_v1 /project/data/shared/

set -e

# Master variables
variables="/userpath/variables.sh"
source ${variables}

mkdir -p ${RELEASE_DNA_SNV_INDEL_V1}

# Redirect stdout and stderr to tee, writing both to console and to a log file
(
echo "START AT $(date)"
echo "Path for RELEASE_DNA_SNV_INDEL_V1:"
echo "${RELEASE_DNA_SNV_INDEL_V1}"

# Start copy of release data:
echo "Copying PCA files..."
rsync -avz -P ${PCA_DATA}/PCA ${RELEASE_DNA_SNV_INDEL_V1}/

# Copy this script to destination as a log
cp release_dna_snv_indel_v1.sh ${RELEASE_DNA_SNV_INDEL_V1}/release_dna_snv_indel_v1.sh.log

# Copy to shared all
echo "Copying full release to shared..."
cp -r ${RELEASE_DNA_SNV_INDEL_V1} ${SHARED_ALL}
echo "Generating MD5 checksums recursively for all files..."
cd ${SHARED_ALL}/release_dna_snv_indel_v1
find . -type f -exec md5sum {} + > checksums.md5
echo "Checksums stored in checksums.md5"

echo "END AT $(date)"
) | tee -a ${RELEASE_DNA_SNV_INDEL_V1}/release_dna_snv_indel_v1.out
```

## Checksums

All files are logged with their md5 checksum.
To verify integrity run: `md5sum -c checksums.md5`

```
$ cat checksums.md5
457dc93749669bed628575dfe551bdac  ./release_dna_snv_indel_v1.sh.log
d35670b5ac26302b19f07c4cf3a96977  ./release_dna_snv_indel_v1.out
```

```
$ md5sum -c checksums.md5
./release_dna_snv_indel_v1.sh.log: OK
./release_dna_snv_indel_v1.out: OK
```

