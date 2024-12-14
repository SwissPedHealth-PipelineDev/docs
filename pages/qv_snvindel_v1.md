---
layout: default
math: mathjax
title: QV SNV INDEL v1
nav_order: 5
---

Last update: 20241214

# Qaulifying variant protocol: SNV INDEL v1

* TOC
{:toc}

## Introduction

This pages summarises the qualifying variant (QV) protocol used for `SNV INDEL v1`. 
This relates to any subjective choices where variants are filtered out for use in downstream analysis. 
In general, most choices are based on well established best practices. 
However, it is important for users to understand whether their QV is suited to a particular context.
You can read about QV in this review
[^povysil2019rare]
<https://www.nature.com/articles/s41576-019-0177-4/>.

Examples of QV sets:

* QC only QV (a very large remaining variant dataset, e.g. >500'000 variants per subject)
* Rare disease QV (small dataset with strict filters, e.g. 10'000 variants per subject)
* Flexible QV (disease-causing candidate variants with modest filtering to balance QC and false positives, e.g. <100'000 variants per subject).


Several QV protocols can be piped together to create increasingly filtered datasets to match the needs at a certain stage of analysis.
It is also typical that different analysis from QVs sets are used and the final results from each step are merged to cover multiple scenarios.
For example: `SNV/INDEL QV` + `CNV QV` + `rare disease known QV` + `statitcal assossiation QC` may be merged to reach the final analysis of (1) single case-level known disease causing results with (2) newly identified cohort-level genes associated with disease. 

## Protocol

This protocol shown here (`SNV INDEL v1`) is considered as the flexible format.

* `01_fastp.sh` The tool fastp is used for QC. FASTQ that fail are investigated or removed. See [fastp](fastp.html) for more.
* `05_rmdup_merge.sh` is used to mark optical duplicates. See [GATK Duplicates](design_doc/gatk_duplicates.html) for more.
* `07_haplotype_caller.sh` used `-ERC GVCF` mode. This does not remove variants but unlike `BP_RESOLUTION`, `GVCF` mode condenses non-variant blocks which could be misunderstood later as missing if not recongnised by the user, for example in a genotype matrix which has been merged with other cohorts.  See [VCF](vcf.html) and [VCF and gVCF](vcf_gvcf.html) for more.
* `07c_qc_summary_stats.sh` is used to log QC. This implements `bcftools stats` (<https://samtools.github.io/bcftools/bcftools.html#stats>) and subsequently the bcftools `plot-vcfstats` (<https://samtools.github.io/bcftools/bcftools.html#plot-vcfstats>) using `python -m venv envQCplot` with matplotlib. Subjects fail are investigated or removed.

# References

[^povysil2019rare]: Povysil, G. et al., 2019. Rare-variant collapsing analyses for complex traits: guidelines and applications. _Nature Reviews Genetics_, 20(12), pp.747-759. DOI: [10.1038/s41576-019-0177-4](https://doi.org/10.1038/s41576-019-0177-4).
