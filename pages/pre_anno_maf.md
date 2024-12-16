---
layout: default
title: Pre-annotation MAF
parent: DNA germline short variant discovery
grand_parent: Design documents
nav_order: 8
---

## Pre-Annotation MAF Filtering

### Overview
The Pre-Annotation MAF Filtering step selectively removes variants from VCF files that exceed a specified minor allele frequency threshold. This step is crucial for focusing analyses on rare variants, which are often of particular interest in studies of rare genetic disorders.

### Implementation
The `13_pre_annotation_MAF.sh` script employs vcftools to apply MAF-based filtering to the VCF files prepared in the previous steps. This script is optimized to process multiple chromosomal segments, ensuring that only variants with desired allele frequency characteristics are retained for further analysis.

#### Script Description
Configured for resource-intensive tasks:

- **Nodes**: 1
- **Memory**: 30G
- **CPUs per Task**: 4
- **Time Limit**: 96:00:00
- **Job Name**: maf_pre_annotation
- **Job Array**: Processes up to 25 chromosomal segments.

The script sets up the necessary environment and directories, preparing for efficient execution of MAF filtering.

#### Tools Used
- **vcftools**: This tool is used for applying filters to VCF files based on allele frequency data, effectively removing common variants according to the specified MAF threshold.

#### Process Flow
1. **Input File Checks**:
   - Verifies the presence of input VCF files to ensure that all necessary data is available for processing.

2. **MAF Filtering**:
   - Applies a filter to exclude variants with a MAF higher than the specified threshold (0.4 in this setup), focusing the dataset on rarer variants.
   - Recodes the VCF to include only the variants that pass the filtering criteria.

3. **Output Compression and Indexing**:
   - Compresses the filtered VCF files using bgzip and creates indexed files with tabix to facilitate efficient data retrieval and further processing.

4. **Cleanup**:
   - Removes intermediate files to conserve storage space and maintain a clean working environment.

### Quality Assurance
This step includes detailed logging of all operations and stringent checks to ensure that filtering is applied correctly and comprehensively. Error handling mechanisms safeguard against potential data processing issues.

### Conclusion
MAF filtering is a critical component of our variant analysis pipeline, enabling researchers to focus on variants of interest by filtering out common genetic variations. This process not only refines the dataset but also ensures that subsequent analyses, such as variant annotation and association studies, are more targeted and meaningful.

