---
layout: default
title: GATK Haplotype caller
parent: DNA germline short variant discovery
grand_parent: Design documents
nav_order: 3
---

## Haplotype Calling

### Overview
Haplotype calling is a critical step in our pipeline, involving the identification of variants from sequenced DNA by constructing haplotypes. This step uses the Genome Analysis Toolkit's (GATK) HaplotypeCaller, which allows for calling high-confidence variants.

### Implementation
The script `07_haplotype_caller.sh` is designed to manage this intensive computational task effectively, utilizing SLURM for job scheduling to handle potentially large genomic datasets.

#### Script Description
Configured to maximize efficiency given computational constraints:

- **Nodes**: 1
- **Memory**: 4G
- **CPUs per Task**: 2
- **Time Limit**: 48:00:00
- **Job Name**: hc
- **Job Array**: Capable of handling 1-68 samples concurrently.

The script begins by setting up the necessary computing environment, sourcing variables, and preparing input and output directories.

#### Tools Used
- **GATK (v4.4.0.0)**: Utilized for the HaplotypeCaller tool, which is executed under specific java options to manage memory usage and parallel processing capabilities.

#### Process Flow
1. **File Preparation**:
   - Finds recalibrated BAM files from the previous BQSR step.
   - Each BAM file is assigned to a SLURM job based on its array task ID.

2. **Variant Calling Execution**:
   - HaplotypeCaller runs with parameters to produce a genomic VCF (gVCF) for each sample, which includes variant calls along with confidence scores.
   - Outputs are genomic VCF files named after each sample, stored in the designated output directory.

3. **Optimization and Debugging**:
   - Detailed logging of the script's execution, including start and end times, input and output details, and memory settings, helps in troubleshooting and ensuring reproducibility.

### Quality Assurance
This stage of the pipeline includes detailed logging and error checking to ensure that the haplotype calling process is robust against computational failures and produces reliable results.

### Conclusion
The Haplotype Calling step is pivotal for identifying variants accurately, setting the stage for subsequent processes such as variant annotation and interpretation. The use of high-performance computing resources ensures that our pipeline can handle large datasets efficiently and reliably.

