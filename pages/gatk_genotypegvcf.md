---
layout: default
title: GATK Genotyping gVCFs
parent: DNA germline short variant discovery
grand_parent: Design documents
nav_order: 5
---

## Genotyping gVCFs

### Overview
Following the import of genomic variant call format (gVCF) files into a GenomicsDB workspace, the next stage in our pipeline involves genotyping these consolidated gVCFs. This step is crucial for calling variants across multiple samples simultaneously, which enhances the discovery and accuracy of genetic variants.

### Implementation
The `09_genotype_gvcf.sh` script manages the genotyping of variants from the GenomicsDB workspaces. This process uses the GATK's GenotypeGVCFs tool, specifically tailored to handle large genomic datasets with high computational efficiency.

#### Script Description
Configured for intensive computational tasks:

- **Dependency**: Waits for previous jobs to complete, ensuring that all necessary data is available for genotyping.
- **Nodes**: 1
- **Memory**: 30G
- **CPUs per Task**: 2
- **Time Limit**: 96:00:00
- **Job Name**: genotype_gvcf
- **Job Array**: Capable of processing 25 chromosomal segments in one batch.

The script starts by setting up the required environment, sourcing variables, and preparing input and output directories.

#### Tools Used
- **GATK (v4.4.0.0)**: Utilized for its `GenotypeGVCFs` tool, which is designed to perform the final genotyping step on the aggregated gVCF data stored in a GenomicsDB workspace.

#### Process Flow
1. **Input and Output Setup**:
   - Directories are established based on predefined paths, where GenomicsDB workspaces are the input and the output is specified as genomic VCF files.

2. **Execution of Genotyping**:
   - For each job in the array, corresponding to a specific chromosome or chromosomal segment, the script accesses the appropriate GenomicsDB workspace.
   - The `GenotypeGVCFs` command is executed to produce a gVCF file for each chromosome, containing the genotyped variants.

3. **Optimization and Resource Management**:
   - The Java options are configured to optimize memory usage and parallel processing capabilities to manage the large data volumes typically involved in genomic analysis.

### Quality Assurance
This stage includes comprehensive logging and error tracking to ensure the process is executed correctly and efficiently. Each step's outputs are systematically verified to maintain high data integrity and reproducibility.

### Conclusion
Genotyping of gVCFs is an essential process in our DNA Germline Short Variant Discovery pipeline, enabling the detailed analysis of genetic variations across multiple samples. By leveraging high-performance computing resources and sophisticated bioinformatics tools, this step ensures that our pipeline produces accurate and reliable variant calls.

---


