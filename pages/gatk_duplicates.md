---
layout: default
title: GATK Duplicates
parent: DNA germline short variant discovery
grand_parent: Design documents
nav_order: 1
---

## Duplicate Marking and Merging

### Overview
The DNA Germline Short Variant Discovery pipeline includes a crucial step of marking duplicates and merging BAM files. This process is essential for ensuring the accuracy of variant calling by eliminating potential biases introduced by duplicate reads resulting from sequencing artifacts.

### Implementation
The `rmdup_merge.sh` script orchestrates this process using high-throughput computational resources managed by the SLURM job scheduler. The script is tailored for operation on a distributed computing environment and is designed to handle large-scale datasets efficiently.

#### Script Description
The script is executed with the following SLURM settings:

- **Nodes**: 1
- **Memory**: 22G
- **Tasks**: 16
- **CPUs per Task**: 1
- **Time Limit**: 32:00:00
- **Job Name**: rmdup_merge
- **Array Jobs**: Supports batch processing for 1-140 samples, allowing parallel processing of multiple samples.

The script starts by setting environment variables and loading necessary modules such as Java and GATK. It then reads from a predefined list of BAM files and processes each according to its SLURM array task ID.

#### Tools Used
- **GATK (v4.4.0.0)**: Utilized for its `MarkDuplicatesSpark` tool which identifies and marks duplicate reads in BAM files. This tool is chosen for its ability to handle large datasets and its integration with Apache Spark for improved performance.

#### Process Flow
1. **Input and Output Directories**: Specified through environment variables.
2. **File Preparation**: Reads from a list containing paths to BAM files and maps them to their respective subject IDs.
3. **Execution**:
   - For each subject (or sample), the script merges and marks duplicates across multiple BAM files using `MarkDuplicatesSpark`.
   - It utilizes Spark to perform operations locally but is configured to work under the computational limits specified by SLURM job parameters.
   - Outputs are directed to specified output directories, and each merged BAM file is named after the subject ID.
   
4. **Post-Processing**:
   - Generation of metrics files for each processed BAM to evaluate the quality of the merging and marking steps.
   - Cleanup operations include removing temporary directories created during the job execution to conserve storage space.

### Quality Assurance
This script incorporates error handling and robust logging mechanisms to ensure that each step of the process is recorded for audit and troubleshooting purposes. Output and error logs are saved to specified directories, allowing easy access to detailed run-time logs and error messages.

### Conclusion
The duplicate marking and merging step is pivotal for preparing sequenced data for subsequent analysis phases like variant calling. By integrating robust tools and leveraging high-performance computing resources, our pipeline ensures that data processed through this stage is of the highest fidelity, setting a strong foundation for accurate and reliable variant discovery.

