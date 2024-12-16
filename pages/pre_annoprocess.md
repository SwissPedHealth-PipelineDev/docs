---
layout: default
title: Pre-annotation processing
parent: DNA germline short variant discovery
grand_parent: Design documents
nav_order: 7
---

## Pre-Annotation Processing

### Overview
The Pre-Annotation Processing step refines VCF files prior to detailed annotation. This involves filtering, normalizing, and decomposing variants to ensure that the data fed into the annotation tools is of high quality and structured correctly.

### Implementation
The `12_pre_annotation_processing.sh` script employs a combination of bioinformatics tools including bcftools, GATK, and vt to refine VCF files. This script is designed to handle large datasets efficiently, processing data across multiple chromosomal segments.

#### Script Description
Optimized for high-throughput computing:

- **Nodes**: 1
- **Memory**: 30G
- **CPUs per Task**: 4
- **Time Limit**: 96:00:00
- **Job Name**: pre_annotation
- **Job Array**: Capable of processing up to 25 chromosome segments in one pass.

The script starts by establishing the necessary computational environment and directories for input and output data.

#### Tools Used
- **bcftools**: Used for initial filtering based on quality metrics such as quality score, depth, and genotype quality.
- **GATK (v4.4.0.0)**: Utilized for selecting variants based on filtering criteria.
- **vt**: Applied for decomposing and normalizing variants to a canonical form, simplifying subsequent annotation processes.

#### Process Flow
1. **Initial Filtering**:
   - Filters variants using bcftools based on predefined quality criteria to ensure that only high-quality variants are processed further.

2. **Compression and Indexing**:
   - Compresses the filtered VCF files using bgzip and indexes them with tabix, preparing them for further processing.

3. **GATK Selection**:
   - Selects variants using GATK’s SelectVariants to exclude filtered and non-variant entries, refining the dataset.

4. **Normalization and Decomposition**:
   - Uses vt to decompose multiallelic sites into simpler allelic forms and normalizes them against the reference genome. This step ensures that variants are represented in their simplest form, aiding accurate annotation.

5. **Final Compression and Clean-up**:
   - Compresses and re-indexes the final VCF files for efficient storage and access.
   - Cleans up intermediate files to free storage space and maintain a tidy workspace.

### Quality Assurance
This step includes extensive error handling and logging to ensure that each sub-process is completed successfully. Detailed logs facilitate troubleshooting and ensure reproducibility.

### Conclusion
Pre-Annotation Processing is crucial for preparing VCF files for detailed annotation. By ensuring that the data is high-quality and properly formatted, this step lays the groundwork for accurate and efficient genomic annotation, which is critical for downstream genomic analyses.

