---
layout: default
title: Design DNA SNV INDEL v1
parent: Design documents
has_children: false
nav_order: 5
---


Last update: 20241217

# Design DNA SNV INDEL v1
## Germline short variant discovery (SNVs + Indels) and interpretation

---
* TOC
{:toc}
---

**Protocol name**: `design_dna_snvindel_v1`

## Aims

| Phase   | Aim  | Status              | Task                                                                                                         |
|:-------:|:----:|---------------------|--------------------------------------------------------------------------------------------------------------|
| Phase 2 | (1)  | **Complete**        | Process all WGS from the study cohort  <br><https://www.swisspedhealth.ch><br>to a consensus format.         |
| Phase 2 | (2)  | **1 of 2 complete** | Prepare qualifying variant (QV) sets   <br>for each downstream aim.                                          |
| Phase 2 | (3)  | In progress <br> Test complete | Clinical genetics report per individual<br>(i.e., baseline benchmark of   <br>known disease-causing).        |
| Phase 2 | (4)  | In progress <br> Test complete | Statistical genomics to find new       <br>cohort-level associations with <br>disease (established methods). |
| Phase 2 | (5)  | In progress         | New methods (ML/DL, causal inference)  <br>for individual and cohort-level<br>discovery.                     |

<img src="{{ "pages/design_doc/images/qv_pipeline_vcurrent.png" | relative_url }}" width="75%">

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

## Protocol summary
1. Process all raw WGS into an analysis-ready format - geonmic VCF (gVCF). 
    - The first goal is to process all raw whole genome sequencing (WGS) data into analysis-ready formats, specifically into joint cohort Variant Call Format (VCF) using the emit-ref-confidence (ERC) gVCF mode. This involves using a reference model to emit data with condensed non-variant blocks, adhering to the gVCF format. gVCF is split per chromosome.
1. The joint cohort chromosome level gVCF are filtered into qualifying variants (QV).
1. The QV sets are used individually or mixed to produce the main analysis results:
    - QV set 1 for clinical genetics (known disease-causing) report for each individual
    - QV set 2 for statistical genomics (new associations with established methods) for cohort level discovery
    - QV set 1 or 2 for other methods (ML/DL, causal inference) (new methods) for individual and cohort level discovery
1. Release data.

## Protocol steps

The major processing steps in sequential order are:

* **Aim 1**
    * FASTQ QC - [see DNA QC](dna_qc.html)
    * [FASTP](fastp.html): QC, check adapters, trimming, filtering, splitting/merging.
    * Genome alignment with [BWA](bwa.html) with [reference genome](ref.html) GCA_000001405.15_GRCh38_no_alt_analysis_set
    * [GATK Duplicates](gatk_duplicates.html)
    * [GATK BQSR](gatk_bsqr.html)
    * [GATK Haplotype caller](gatk_hc.html)
    * [GATK Genomic db import](gatk_dbimport.html)
    * [GATK Genotyping gVCFs](gatk_genotypegvcf.html)
    * [GATK VQSR](gatk_vqsr.html)
    * [GATK Genotype refine](gatk_genotyperefine.html)
    * VCF QC - [see DNA QC](dna_qc.html)
* **Aim 2**
    * [Design QV SNV INDEL V1](design_qv_snvindel_v1.html) Qualifying variants (variables and thresholds) SNV INDEL v1
    * [Pre-annotation processing](pre_annoprocess.html): data conversion for simpler handling
    * [Pre-annotation MAF](pre_anno_maf.html): filtering to remove noise
    * [DNA annotation](dna_annotation.html): annotate known effects, biological function, associations
* **Aim 3-5 use a selective mixture of the remaining methods depending on the QV set**
    * [DNA interpretation](dna_interpretation.html)
    * [ACMG criteria](acmg_criteria_table_main.html): Standardised scoring for interpreting variant pathogenicity
    * Clinical genetics reports - not documented here
    * [Design Statistical genomics v1](design_statistical_genomics_v1.html)
    * ML/DL projects - not documented here
* **Release**
    * See [design_dna_snvindel_v1_release](design_dna_snvindel_v1_release.html)

<img src="{{ "pages/design_doc/images/variant_annotation_graph.png" | relative_url }}" width="75%">

Figure 2: Extended methods of figure 1 DNA germline short variant discovery pipeline plan.

## Metrics

Study book data:

1. `CollectWgsMetrics`: `03b_collectwgsmetrics.sh` ->  `study_book/qc_summary_stats` mapping, depth, and more.  See [metrics_collectwgsmetrics](metrics_collectwgsmetrics.html).
1. `bcftools stats` and `plot-vcfstats`: `07c_qc_summary_stats.sh` -> `study_book/qc_summary_stats` gVCF summary after HC. See [metrics_bcftoolsstats](metrics_bcftoolsstats.html).

## Data release

The private internal data release: [design_dna_snvindel_v1_release](design_dna_snvindel_v1_release.html)

