---
layout: default
title: Reference genome
date: 2023-07-27 00:00:01
nav_order: 5
toc: true
---

# Reference genome
Last update: 20241210


## Share

Reference genome datasets are prepared and stored at:
* `/project/data/shared`
    * Read-only
    * Datamanager control
    * Includes: README.md
    * Includes: ref.sh creation

## Genome reference consortium

Go here for the original source:
<https://www.ncbi.nlm.nih.gov/grc/human>

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

## Features of GRCh38/hg38

See GATK for info (<https://gatk.broadinstitute.org/hc/en-us/articles/360035890951-Human-genome-reference-builds-GRCh38-or-hg38-b37-hg19>).

**Primary assembly:**

* Assembled chromosomes for hg38 are chromosomes 1–22 (chr1–chr22), X (chrX), Y (chrY) and Mitochondrial (chrM).
* Unlocalized sequences (known to belong on a specific chromosome but with unknown order or orientation) are identified by the _random suffix.
* Unplaced sequences (chromosome of origin unknown) are identified by the chrU_ prefix.


**Legacy assemblies:**

GRCh37/b37 and Hg19

For these builds, the primary assembly coordinates are identical for the original release but patch updates were different. In addition, the naming conventions of the references differ, e.g. the use of chr1(in hg19) versus 1 (in b37) to indicate chromosome 1, and chrM vs. MT for the mitochondrial genome. 
* chr1(in hg19) 
* 1 (in b37) 

Included decoys were also different. So it is possible to lift-over resources from one to the other, but it should be done using Picard LiftoverVcf with the appropriate chain files. Trying to convert between them just by renaming contigs is a bad idea. And in the case of BAMs, well, the bad news is that if you have a BAM aligned to one reference build but you need the other, you'll have to re-map the data from scratch.


## Other builds
We use GRCh38 but for some old prepared data we must use the existing version with the reference genome used at that time.
The mentioned refernce is "human_g1k_v37_decoy_chr.fasta".
There are 4 common "hg19" references, and they are NOT directly interchangeable:
<https://gatk.broadinstitute.org/hc/en-us/articles/360035890711-GRCh37-hg19-b37-humanG1Kv37-Human-Reference-Discrepancies>
