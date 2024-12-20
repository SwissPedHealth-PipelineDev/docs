---
layout: default
title: Design PCA SNV INDEL v1
parent: Design documents
has_children: false
nav_order: 5
---

Last update: 20241220

# Design PCA SNV INDEL v1

We prepare two datasets:

- (a) 1KG reference population: input `${THOUSAND_GENOMES}/phase3.chr"${INDEX}".GRCh38.GT.crossmap.vcf.gz`
- (b) SwissPedHealth: input  `${PRE_ANNOTATION_DIR}/chr${INDEX}_bcftools_gatk_norm.bcf`

* We prepare with bcftools and convert to bcf.
* We then convert to PLINK format.
* Prune variants :
    * `--maf 0.10`, only retain SNPs with MAF greater than 10%
    * `--indep [window size] [step size/variant count)] [Variance inflation factor (VIF) threshold]`
    * e.g. indep 50 5 1.5, Generates a list of markers in approx. linkage equilibrium - takes 50 SNPs at a time and then shifts by 5 for the window. VIF     (1/(1-r^2)) is the cut-off for linkage disequilibrium
* Merge to single files
* Merge (a) and (b) = (c)
* PCA on each of (a-c) for individual datasets and plots

Output: `${PCA_DATA}/prune/`

## Additional pruning for consideration

<https://genome.sph.umich.edu/wiki/Regions_of_high_linkage_disequilibrium_(LD)>

