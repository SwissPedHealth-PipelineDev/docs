---
layout: default
title: Reference genome
date: 2023-07-27 00:00:01
nav_order: 5
---

Last update: 20230727


## Share

Reference genome datasets are prepared and stored at:
* `/poject/data/ref`
    * Read-only
    * Datamanager control
    * Includes: README.md
    * Includes: ref.sh creation

## GRCh38
### Choice

Reference genome choice is discussed succinctly in many difference places.
Therefore, we link other usefull sources.

* Heng Li - Which human reference genome to use?
<https://lh3.github.io/2017/11/13/which-human-reference-genome-to-use>

* Illumina review
<https://www.illumina.com/science/genomics-research/articles/dragen-demystifying-reference-genomes.html>

Our reference genome was donwloaded and installed by `ref.sh` which does the following:

### Installation
* Get local copy
```
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz`
```

* Get checksum
```
md5 GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz > GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz.md5
```

* Transfer to cluster
```
sftp username@cluster
cd data/ref
put GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz
put GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz.md5
put ref.sh
```

* Preparation
* Once downloaded we need the index which is done by
```
bwa index GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz
```

## Other builds
We use GRCh38 but for some old prepared data we must use the existing version with the reference genome used at that time.
The mentioned refernce is "human_g1k_v37_decoy_chr.fasta".
There are 4 common "hg19" references, and they are NOT directly interchangeable:
<https://gatk.broadinstitute.org/hc/en-us/articles/360035890711-GRCh37-hg19-b37-humanG1Kv37-Human-Reference-Discrepancies>