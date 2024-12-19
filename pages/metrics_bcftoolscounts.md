---
layout: default
math: mathjax
title: Metrics Bcftools counts
nav_order: 5
---

Last update: 20241219

# Metrics Bcftools counts

This is the main source of basic variant counts when understanding the effects of a qualifying variant (QV) design.

The script shown below runs on a set of gVCF directories (`INPUT_DIRS`) where incremental filtering has reduces the dataset in each sequential step. 
A pyramid filtering plot is likely to use such count data. 

**Example output**:

* Number of samples: 180
* Number of SNPs:    97296
* Number of INDELs:  17945
* Number of MNPs:    0
* Number of others:  0
* Number of sites:   112132

Usage Example:

```
#!/bin/bash

#SBATCH --array=0-24
...
...

set -e
echo "START AT $(date)"

variables="/path/variables.sh"
source ${variables}
QV_MODEL="Design_QV_SNV_INDEL_v1"

# Tools setup
module load StdEnv/2023 gcc/12.3 bcftools/1.19

# Input directories setup
declare -a INPUT_DIRS=(
	"${VQSR_DIR}"
	"${GENOTYPE_REFINEMENT_DIR}"
	"${PRE_ANNOTATION_DIR}"
	"${PRE_ANNOTATION_MAF_DIR}"
	"${ANNOTATION_DIR}"
	"${ANNOTATION_GNOMAD_DIR}"
)

declare -a NUMBER
for j in {1..22} X Y M; do NUMBER+=($j); done
INDEX=${NUMBER[$SLURM_ARRAY_TASK_ID]}

# Processing each directory
for INPUT_DIR in "${INPUT_DIRS[@]}"; do

	echo " "
	echo "Working on directory: ${INPUT_DIR}"
	
	# Create an array of VCF files for the current chromosome
	mapfile -t vcf_files < <(ls ${INPUT_DIR}/chr${INDEX}_*.vcf.gz)
	
	# Process each VCF file in the directory
	for vcf in "${vcf_files[@]}"; do
		# Output file path for count results
		count_out="${QC_SUMMARY_STATS}/all_gvcf/${QV_MODEL}_$(basename "${vcf}" .vcf.gz)_qc.log"
		
		# Get basic variant counts
		echo "Input: ${vcf}"
		echo "Output: ${count_out}"
		bcftools +counts "${vcf}" > "${count_out}"
	done
done

echo "END AT $(date)"
```
