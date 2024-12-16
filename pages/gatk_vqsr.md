---
layout: default
title: GATK VQSR
parent: DNA germline short variant discovery
grand_parent: Design documents
nav_order: 6
---

## Variant Quality Score Recalibration (VQSR)

### Overview
Variant Quality Score Recalibration (VQSR) is an advanced technique used in our pipeline to assess and recalibrate the confidence scores of identified variants. By using known, reliable sources as benchmarks, VQSR improves the accuracy of variant calls, distinguishing true biological variants from technical artifacts.

### Implementation
The `10_vqsr.sh` script executes the VQSR process using GATK's VariantRecalibrator and ApplyVQSR tools. This script is configured for high-demand computational tasks to handle variant data across all chromosome segments.

#### Script Description
Optimized for high-throughput:

- **Nodes**: 1
- **Memory**: 30G
- **CPUs per Task**: 4
- **Time Limit**: 96:00:00
- **Job Name**: vqsr
- **Job Array**: Capable of processing 25 chromosome segments in a single run.

The script begins by preparing the environment, loading necessary modules, and setting up directories.

#### Tools Used
- **GATK (v4.4.0.0)**: Employed for both the VariantRecalibrator and ApplyVQSR tools, which together adjust the quality scores of variants based on their statistical likelihood of being true genetic variants.

#### Process Flow
1. **Input Setup**:
   - Retrieves gVCF files for each chromosome from the previous genotyping step.

2. **Execution of VQSR**:
   - For SNPs and INDELs, separate recalibration and application steps are performed:
     - **VariantRecalibrator**: Generates recalibration models based on a set of user-defined annotations and known variant sites.
     - **ApplyVQSR**: Applies the recalibration model to the variant calls, filtering or adjusting their quality scores based on the recalibration.

3. **Known Sites and Resources**:
   - Utilizes multiple databases such as HapMap, Omni, 1000 Genomes, and Mills for recalibration, which help in training the recalibration model to distinguish between high-confidence and low-confidence variants.

4. **Output Generation**:
   - Produces recalibrated VCF files for SNPs and INDELs, which are stored in specified output directories.

### Quality Assurance
Includes extensive logging and monitoring of the recalibration process to ensure accuracy and efficiency. Error handling and checkpointing ensure that the process can resume from intermediate stages in case of failures.

### Conclusion
VQSR is essential for our DNA Germline Short Variant Discovery pipeline as it refines variant calls, enhancing the reliability and accuracy of downstream genetic analyses. This process leverages comprehensive known variant datasets and robust computational resources to maintain high standards of variant calling.

---


