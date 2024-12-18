---
layout: default
title: SLURM sbatch headers 
nav_order: 5
---

# SLURM sbatch headers
Last update: 20240820

Here we outline the usage of SLURM sbatch headers to efficiently manage jobs that process genomic data across multiple samples, chromosomes, or genomic regions.

{: .note }

Some nodes show 32G memory on their partition but will not run jobs that have more than #SBATCH --mem 28G. Keep this in mind for other types of overheadthat might prevent a job from launching.

## Key SLURM sbatch directives

Here are examples of SLURM sbatch headers used in our scripts:

```bash
#!/bin/bash
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 4
#SBATCH --mem 30G
#SBATCH --time 96:00:00
#SBATCH --job-name=genomic_analysis
#SBATCH --output=/path/to/log/%x_%A_%a_%J.out
#SBATCH --error=/path/to/log/%x_%A_%a_%J.err
#SBATCH --partition=all-nodes-cpu
#SBATCH --array=1-1215
```

### Explanation of directives

- `--nodes`: Number of nodes required.
- `--ntasks`: Number of tasks.
- `--cpus-per-task`: Number of CPUs per task.
- `--mem`: Memory required.
- `--time`: Time limit.
- `--job-name`: Name of the job.
- `--output` and `--error`: Output and error file paths.
- `--partition`: Specifies the partition.
- `--array`: Job array settings to split tasks.


### Common output and error placeholders:

- **`%x`**: Job name specified by `--job-name`.
- **`%A`**: Job ID for the array job.
- **`%a`**: Array index of the specific task within a job array.
- **`%J`**: Job ID with an optional array task ID, formatted as `jobID_arrayID` (or just `jobID` for non-array jobs).

### Additional placeholders:

- **`%j`**: The job ID, used when no array is involved.
- **`%N`**: Short hostname of the first compute node where the job runs.
- **`%n`**: Node index relative to the job.
- **`%u`**: Username of the job owner.

### Examples:

- Track job details: `--output=/path/to/log/%x_%A_%a_%J.out`
- Log by node: `--output=/path/to/log/%x_%N.out`
- User-specific logs: `--output=/path/to/log/%u_%x_%j.out`

### Best practices:

- **Organize Logs**: Use structured directories and naming conventions.
- **Use Unique Identifiers**: Include `%J` or `%A_%a` to prevent overwrites.
- **Maintain Privacy**: Be cautious about sensitive information in filenames.

## Using `SLURM_ARRAY_TASK_ID`

The `SLURM_ARRAY_TASK_ID` is used to assign specific tasks within a job array. Each task can be used to process a specific file or a part of the dataset.

### Example: Genomic analysis per sample

This example shows how to use `SLURM_ARRAY_TASK_ID` to process individual genomic samples:

```bash
#!/bin/bash
#SBATCH --array=0-99  # Adjust based on the number of samples

# Assuming BAM_FILES is an array containing paths to BAM files
BAM_FILES=("/path/to/sample1.bam" "/path/to/sample2.bam" ...)

SMOOVE="singularity exec ${DATA}/smoove_latest.sif smoove"
EXCLUDE_BED="/path/to/exclude.bed"
REF_NONZIP="/path/to/reference.fasta"
OUTDIR="/path/to/output"

SAMPLE_ID=$(basename ${BAM_FILES[$SLURM_ARRAY_TASK_ID]} .bam)
$SMOOVE call --outdir $OUTDIR \
--exclude $EXCLUDE_BED \
--name $SAMPLE_ID \
--fasta $REF_NONZIP \
-p 1 \
--genotype ${BAM_FILES[$SLURM_ARRAY_TASK_ID]}
```

### Example: Processing genomic data by chromosome

This example demonstrates setting up an array to process data by chromosome:

```bash
#!/bin/bash
#SBATCH --array=0-24  # For chromosomes 1..22, X, Y, M

declare -a CHROMOSOMES=('1' '2' '3' ... '22' 'X' 'Y' 'M')
CHROM=${CHROMOSOMES[$SLURM_ARRAY_TASK_ID]}

INPUT_DIR="/path/to/vcfs"
OUTPUT_DIR="/path/to/output"
VCF_FILE="${INPUT_DIR}/chr${CHROM}_data.vcf.gz"
OUTPUT_VCF="${OUTPUT_DIR}/chr${CHROM}_processed.vcf.gz"

echo "Processing chromosome: ${CHROM}"
echo "Input: ${VCF_FILE}"

# Check if the input file exists
if [[ ! -f "$VCF_FILE" ]]; then
  echo "Input file for chromosome ${CHROM} does not exist: $VCF_FILE"
  echo "Skipping processing for this job."
  exit 0
fi

# Run processing commands
bcftools filter -i 'QUAL>=30 & INFO/DP>=20' -Oz -o ${OUTPUT_VCF} ${VCF_FILE}
```

## Conclusion

Utilizing SLURM sbatch headers and the `SLURM_ARRAY_TASK_ID` variable efficiently parallelizes tasks across a cluster, enhancing throughput for large-scale genomic analyses.

