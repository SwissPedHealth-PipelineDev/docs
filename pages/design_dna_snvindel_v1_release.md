---
layout: default
title: Design release DNA SNV INDEL v1
parent: Design documents
has_children: false
nav_order: 5
---


Last update: 20250102

# Design release DNA SNV INDEL v1

**Protocol name**: `design_dna_snv_indel_v1_relsease` (this document) for `design_dna_snvindel_v1` (see [design_dna_snvindel_v1](design_dna_snvindel_v1.html)).

---
* TOC
{:toc}
---

{: .highlight-title }
> Release information
>
> **Current release version**: v1\\
> **Location temp**: `/project/data/shared_all/release_dna_snv_indel_v1`\\
> **Location stable**: `/project/data/shared/release_dna_snv_indel_v1`


{: .new-title }
> Status
>
> **Status**: `design_dna_snv_indel_v1_relsease` is currently **recommended**.\\
> \\
> Any modifications due to error will be notified and a new release ID will be issued (e.g. `design_dna_snv_indel_v1.2_relsease`).


## About

If you are reading this then you are interested in using the release data from 
the `design_dna_snvindel_v1` pipeline.
This pipeline produces a multi-use dataset via the qualifying variants 1 (QV1) protocol.
Incremental additions with new data for this release will be added.
Potential uses are suggested as the end-points in figure 1 (e.g. statistical genomics, etc.)

The protocol used was:
1. [design_dna_snvindel_v1](design_dna_snvindel_v1.html)
    * [design_PCA_SNV_INDEL_v1](design_PCA_SNV_INDEL_V1.html)
    * [design_qv_snvindel_v1](design_qv_snvindel_v1.html)

<img src="{{ "pages/design_doc/images/qv_pipeline_vcurrent.png" | relative_url }}" width="75%">

Figure 1: Summary of design DNA SNV INDEL v1 pipeline plan.

## Data synchronisation process

1. Sync release data to `shared_all`.
1. Log and verify data during sync to `shared_all`.
1. Data manager syncs from `shared_all` to `shared`.
1. The final release is locked in `shared` but allows incremental additions.
1. Labelled as `release_dna_snv_indel_v1`.

## Data Availability

All raw and processed data are accessible to all internal researchers. 
Processed/intermediate data might change during projects, so released data is recommended for downstream projects. 
Release data should have detailed supporting documentation following the protocol. 
Essential data is curated to minimise storage use. 
Non-release data is accessible as usual from user directories but may be overwritten or updated without notice. 
Data paths are listed in the release script, generally read from a master list of variables.

## Current contents

[dna_snv_indel_v1_release.README.md](dna_snv_indel_v1_release.README.md)

---

### Release DNA SNV INDEL v1

* Name: `release_dna_snv_indel_v1` <https://swisspedhealth-pipelinedev.github.io/docs/pages/design_dna_snvindel_v1_release.html>
* Source: `design_dna_snvindel_v1` <https://swisspedhealth-pipelinedev.github.io/docs/pages/design_dna_snvindel_v1.html>
* Tree:

```
├── annotation
├── checksums.md5
├── dna_snv_indel_v1_release.out
├── dna_snv_indel_v1_release.README.md
├── dna_snv_indel_v1_release.sh.log
└── PCA
```

#### QV1 gVCF files

* `source: ${ANNOTATION_DIR}`
* `${RELEASE_DNA_SNV_INDEL_V1}/annotation/chr*_bcftools_gatk_norm_decom_maf.recode_vep_dbnsfp.vcf.gz*`

#### QV1 gVCF logs

* `source: /data/wgs/log/annotation`
* `${RELEASE_DNA_SNV_INDEL_V1}/annotation/log`

#### QV1 gVCF scripts

* `source: 14_annotation_conda.sh`
* `${RELEASE_DNA_SNV_INDEL_V1}/annotation/14_annotation_conda.sh.log`

#### PCA files

* `source: ${PCA_DATA}/PCA`

#### PCA scripts

* `${RELEASE_DNA_SNV_INDEL_V1}/PCA`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/19a_pca_prep_1kg.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/20a_pca_1kg.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/20c_pca_1kg_swisspedhealth.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/19b_pca_prep_swisspedhealth.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/20b_pca_swisspedhealth.sh.log`
* `${RELEASE_DNA_SNV_INDEL_V1}/PCA/21b_pca_biplot_1kg_part3_ggplot_vcurrent.R.log`

---

## Current version script

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

# Copy this script to destination as a log
cp dna_snv_indel_v1_release.sh ${RELEASE_DNA_SNV_INDEL_V1}/dna_snv_indel_v1_release.sh.log

# 1 \\\\\\\\\\\\\\\\\\\\\\\
echo "Copying README.md..."
cp dna_snv_indel_v1_release.README.md ${RELEASE_DNA_SNV_INDEL_V1}/

# 2 \\\\\\\\\\\\\\\\\\\\\\\
echo "Copying QV1 gVCF files..."
echo "QV1 analysis output is ${ANNOTATION_DIR}/chr*_bcftools_gatk_norm_decom_maf.recode_vep_dbnsfp.vcf.gz*"
rsync -avz -P ${ANNOTATION_DIR}/chr*_bcftools_gatk_norm_decom_maf.recode_vep_dbnsfp.vcf.gz* \
        ${RELEASE_DNA_SNV_INDEL_V1}/annotation

echo "Copying QV1 gVCF logs..."
rsync -avz -P /data/wgs/log/annotation \
        ${RELEASE_DNA_SNV_INDEL_V1}/annotation/log

echo "Copying QV1 gVCF script..."
rsync -avz -P 14_annotation_conda.sh \
        ${RELEASE_DNA_SNV_INDEL_V1}/annotation/14_annotation_conda.sh.log

# 3 \\\\\\\\\\\\\\\\\\\\\\\
echo "Copying PCA files..."
rsync -avz -P ${PCA_DATA}/PCA ${RELEASE_DNA_SNV_INDEL_V1}/

rsync -avz -P 19a_pca_prep_1kg.sh ${RELEASE_DNA_SNV_INDEL_V1}/PCA/19a_pca_prep_1kg.sh.log
rsync -avz -P 20a_pca_1kg.sh ${RELEASE_DNA_SNV_INDEL_V1}/PCA/20a_pca_1kg.sh.log
rsync -avz -P 20c_pca_1kg_swisspedhealth.sh ${RELEASE_DNA_SNV_INDEL_V1}/PCA/20c_pca_1kg_swisspedhealth.sh.log
rsync -avz -P 19b_pca_prep_swisspedhealth.sh ${RELEASE_DNA_SNV_INDEL_V1}/PCA/19b_pca_prep_swisspedhealth.sh.log
rsync -avz -P 20b_pca_swisspedhealth.sh ${RELEASE_DNA_SNV_INDEL_V1}/PCA/20b_pca_swisspedhealth.sh.log
rsync -avz -P 21b_pca_biplot_1kg_part3_ggplot_vcurrent.R ${RELEASE_DNA_SNV_INDEL_V1}/PCA/21b_pca_biplot_1kg_part3_ggplot_vcurrent.R.log

# Sync \\\\\\\\\\\\\\\\\\\\\\\
# Copy to shared all
echo "Copying full release to shared..."
cp -r ${RELEASE_DNA_SNV_INDEL_V1} ${SHARED_ALL}
echo "Generating MD5 checksums recursively for all files..."
cd ${SHARED_ALL}/dna_snv_indel_v1_release
find . -type f -exec md5sum {} + > checksums.md5
echo "Checksums stored in checksums.md5"

echo "END AT $(date)"
) | tee -a ${RELEASE_DNA_SNV_INDEL_V1}/dna_snv_indel_v1_release.out

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

