---
layout: default
title: GATK BQSR
parent: DNA germline short variant discovery
grand_parent: Design documents
nav_order: 2
---

## Base Quality Score Recalibration (BQSR)

### Overview
The Base Quality Score Recalibration (BQSR) step in our pipeline is designed to adjust the base quality scores in BAM files based on known sites of variation and sequencing artifacts. This recalibration helps to mitigate biases that might have been introduced during sequencing.

### Implementation
The `06_bqsr.sh` script manages the BQSR process using the Genome Analysis Toolkit (GATK). It operates within a high-throughput computational framework facilitated by the SLURM job scheduler, specifically configured for efficient handling of genomic data.

#### Script Description
The script employs specific SLURM settings to optimize the use of computational resources:

- **Nodes**: 1
- **Memory**: 6G
- **CPUs per Task**: 4
- **Time Limit**: 32:00:00
- **Job Name**: bqsr
- **Job Array**: Processes batches of 1-8 samples simultaneously.

The script initializes by setting up the necessary environment, loading computational modules, and defining input and output directories based on predefined variables.

#### Tools Used
- **GATK (v4.4.0.0)**: Used for its `BaseRecalibrator` and `ApplyBQSR` tools to recalibrate base quality scores based on multiple known sites databases.

#### Process Flow
1. **File Handling**:
   - Locates BAM files previously processed for duplicate marking and merging.
   - Assigns each file to a specific SLURM array job based on its task ID.
   
2. **Recalibration Execution**:
   - The `BaseRecalibrator` tool generates a recalibration table based on the input BAM, a reference genome, and known variant sites.
   - The `ApplyBQSR` tool then adjusts the base quality scores using the generated recalibration table, producing a recalibrated BAM file.

3. **Known Sites**:
   - Multiple databases are used as references for known sites, including dbSNP and the Mills and 1000 Genomes gold standard indels, to ensure comprehensive coverage and accuracy in recalibration.

4. **Output**:
   - Each sample results in a recalibrated BAM file and an accompanying BQSR table, stored in the designated output directory.

### Quality Assurance
This step includes detailed logging of each process, capturing standard output and errors to facilitate troubleshooting and ensure reproducibility. The script also features robust error handling mechanisms to address potential failures during the recalibration process.

### Conclusion
BQSR is a critical component of our variant discovery pipeline, enhancing the reliability of variant calls by refining the accuracy of base quality scores in sequenced data. By leveraging advanced tools and high-performance computing resources, this step ensures that subsequent analyses are based on the highest quality data.

