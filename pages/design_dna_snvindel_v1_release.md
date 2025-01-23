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



## Contents

See the README.md for this release to find files:

[dna_snv_indel_v1_release.README.md](dna_snv_indel_v1_release.README.md)

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


## Current version script

`release_dna_snv_indel_v1.sh` is run from the user src directory.

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

