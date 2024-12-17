---
layout: default
title: Design DNA SNV INDEL v1
parent: Design documents
has_children: true
---

<h1>
Design DNA SNV INDEL v1 - Germline short variant discovery (SNVs + Indels) and interpretation</h1>
<h2>Design document</h2>

---

<img 
src="{{ "pages/design_doc/images/mcl_skat_4_extended_vcurrent.png" | relative_url }}"
width="100%">
Figure 1: Summary of design DNA SNV INDEL v1 pipeline plan.

## Introduction

This protocol is designed to process DNA WGS data in FASTQ format into qualifying qariants (QV) based on consensus variables and thresholds (figure 1).
The QV can then be used in multiple applications such as ML/DL to find disease-related variants or gene functions.
Additionally, in the clinical genetic protocol further standardised filtering criteria are used to reach a single genetic determinant in a clinical genetics report for each subject.
The design name 
`Design DNA SNV INDEL v1`
indicates that this protocol is tailored to single nucleotide variants (SNVs) and short insertion/deletions (INDELs) (e.g. GATK pipeline). 
We implement the genome analysis tool kit 
[GATK](https://gatk.broadinstitute.org/hc/en-us)
best practices workflow for 
[germline short variant discovery](https://gatk.broadinstitute.org/hc/en-us/articles/360035535932-Germline-short-variant-discovery-SNPs-Indels) (open source licence [here](https://github.com/broadinstitute/gatk/blob/master/LICENSE.TXT)).
This GATK workflow is designed to operate on a set of samples constituting a study cohort; 
specifically, a set of per-sample BAM files that have been pre-processed as described in the GATK Best Practices for data pre-processing.

Our main uses from the prepared QV set are:

- clinical genetics (known disease-causing)
- statistical genomics (new associations with established methods)
- other methods (ML/DL, causal inference) (new methods)

## Protocol

* FASTQ QC - [see DNA QC](dna_qc.html)
* [FASTP](fastp.html): QC, check adapters, trimming, filtering, splitting/merging.
* Genome alignment with [BWA](bwa.html)
    - with [reference genome](ref.html) GCA_000001405.15_GRCh38_no_alt_analysis_set
* [GATK Duplicates](gatk_duplicates.html)
* [GATK BQSR](gatk_bsqr.html)
* [GATK Haplotype caller](gatk_hc.html)
* [GATK Genomic db import](gatk_dbimport.html)
* [GATK Genotyping gVCFs](gatk_genotypegvcf.html)
* [GATK VQSR](gatk_vqsr.html)
* [GATK Genotype refine](gatk_genotyperefine.html)
* VCF QC - [see DNA QC](dna_qc.html)
* [QV SNV INDEL V1](qv_snvindel_v1.html) Qualifying variants (variables and thresholds) SNV INDEL v1
* [Pre-annotation processing](pre_annoprocess.html): data conversion for simpler handling
* [Pre-annotation MAF](pre_anno_maf.html): filtering to remove noise
* [DNA annotation](dna_annotation.html): annotate known effects, biological function, associations
* [DNA interpretation](dna_interpretation.html)
* [ACMG criteria](acmg_criteria_table_main.html): Standardised scoring for interpreting variant pathogenicity

<img 
src="{{ "pages/design_doc/images/variant_annotation_graph.png" | relative_url }}"
width="100%">
Figure 2: Extended methods of figure 1 DNA germline short variant discovery pipeline plan.

## Metrics

Study book data:

1. `CollectWgsMetrics`: `03b_collectwgsmetrics.sh` ->  `study_book/qc_summary_stats` mapping, depth, and more.  See [metrics_collectwgsmetrics](metrics_collectwgsmetrics.html).
1. `bcftools stats` and `plot-vcfstats`: `07c_qc_summary_stats.sh` -> `study_book/qc_summary_stats` gVCF summary after HC. See [metrics_bcftoolsstats](metrics_bcftoolsstats.html).


