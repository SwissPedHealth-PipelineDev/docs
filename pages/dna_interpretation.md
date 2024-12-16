---
layout: default
math: mathjax
title: DNA interpretation
nav_order: 5
---

Last update: 20241216
# DNA Interpretation

* TOC
{:toc}

---

We will perform a range of interpretation steps for:
1. Generalised single-case clinical variant classification
2. Cohort-level classification

For example, we will perform interpretation of variants by ACMG standards and guidelines.
Extensive annotation is applied during our genomics analysis.
Interpretation of genetic determinants of disease is based on many evidence sources.
One important source of interpretation comes from the
Standards and guidelines for the interpretation of sequence variants: a joint consensus recommendation of the American College of Medical Genetics and Genomics and the Association for Molecular Pathology
[richards2015standards], full text at doi:
[10.1038/gim.2015.30](https://www.gimjournal.org/article/S1098-3600(21)03031-8/fulltext).

Check the tables linked here:
[temporary link](https://lawlessgenomics.com/topic/acgm-criteria-table-main).
These are provided as they appear in the initial steps of our filtering protocol for the addition of ACMG-standardised labels to candidate causal variants.
* Criteria for classifications
* Caveats implementing filters

Implementing the guidelines for interpretation of annotation requires multiple programmatic steps. 
The number of individual caveat checks indicate the number of bioinformatic filter functions used.
Unnumbered caveat checks indicate that only a single filter function is required during reference to annotation databases.
However, each function depends on reference to either one or several evidence source databases (approximately 160 sources).

For reference, alternative public implementations of ACMG guidelines can be found in [li2017intervar] and [xavier2019tapes];
please note these tools have not implemented here nor is any assertion of their quality offered.
Examples of effective variant filtering and expected candidate variant yield in studies of rare human disease are provided by [pedersen2021effective].


We plan to use our tools built for these requirements which are currently in review:
* ACMGuru for automated clinical genetics evidence interpretation. 
* ProteoMCLustR for unbiased whole-genome pathway clustering; 
* SkatRbrain for statistical sequence kernel association testing with variant collapse.
* UntangleR for pathway visualisation.
* AutoDestructR for protein structure variant mapping. 
All tools were designed for modular automated high-performance computing. 

