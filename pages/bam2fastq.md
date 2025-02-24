---
layout: default
title: BWA
nav_order: 5
---

# BAM to fastq

Last update: 20240227

See reference: <https://www.metagenomics.wiki/tools/samtools/converting-bam-to-fastq>

We have WGS data aligned to an old reference genome which required updated analysis.
We must convert BAM to FASTQ so that we can re-align.
For subsequent re-alignement we will use BWA.
The Samtools method is the most reasonable first approach bacuase it was written by the author of BWA, Heng Li, with modifications by Martin Pollard and Jennifer Liddle, all from the Sanger Institute. 
The other alternative methods are listed below for comparison.

## SAMtools

* sort paired read alignment .bam file (sort by name -n)

```
samtools sort -n SAMPLE.bam -o SAMPLE_sorted.bam
````
* save fastq reads in separate R1 and R2 files

```
samtools fastq -@ 8 SAMPLE_sorted.bam \
    -1 SAMPLE_R1.fastq.gz \
    -2 SAMPLE_R2.fastq.gz \
    -0 /dev/null -s /dev/null -n
```

<http://www.htslib.org/doc/samtools-fasta.html>

On our system:

* `save fastq reads in separate R1 and R2 files`
* Example input: 78G BAM file aligned to GRCh37
* Example output: Size R1 and R2 FASTQ
* Time: 1hr 30min
* Expected size: 70 GB per subject (total FASTQ)
* Memory use: 1GB

```
#SBATCH --nodes 1
#SBATCH --ntasks 1
#SBATCH --cpus-per-task 1
#SBATCH --mem 24G
#SBATCH --time 12:00:00
```

```
# Result indicates that reads are not paired and we require singletons
bam2fastq_1_40002.err
[M::bam2fq_mainloop] discarded 903778738 singletons
[M::bam2fq_mainloop] processed 909146794 reads
```




## Collate interleaved

```
echo "samsort collate shuffles and groups reads together by their names."
samtools sort -n ${TEMP_DIR}/${file1} -o ${TEMP_DIR}/${file1}_collate.bam
echo "samsort -n complete"

echo "bam2fastq for interleaved file start"
samtools fastq -@ 8 \
-0 /dev/null \
${TEMP_DIR}/${file1}_collate.bam \
> ${TEMP_DIR}/${file1}_all_reads.fq
```


## Paried files

```
echo "samsort -n start"
samtools sort -n ${TEMP_DIR}/${file1} -o ${TEMP_DIR}/${file1}_sortn.bam
echo "samsort -n complete"

echo "bam2fastq for paired files start"
samtools fastq -@ 8 ${TEMP_DIR}/${file1}_sortn.bam \
-1 ${TEMP_DIR}/${file1}_R1.fastq.gz \
-2 ${TEMP_DIR}/${file1}_R2.fastq.gz \
-0 /dev/null -s /dev/null -n
```

* Using bam2fq
```
samtools bam2fq SAMPLE.bam > SAMPLE.fastq
```
paired-end reads:   '/1' or '/2' is added to the end of read names
<http://www.htslib.org/doc/samtools.html>

* How to split a single .fastq file of paired-end reads into two separated files?
```
# extracting reads ending with '/1' or '/2'
cat SAMPLE.fastq | grep '^@.*/1$' -A 3 --no-group-separator > SAMPLE_R1.fastq
cat SAMPLE.fastq | grep '^@.*/2$' -A 3 --no-group-separator > SAMPLE_R2.fastq
```

## Picard

* converting a SAMPLE.bam file into paired end SAMPLE_R1.fastq and SAMPLE_R2.fastq files

	- F2   to get two files for paired-end reads (R1 and R2)
	- -Xmx2g allows a maximum use of 2GB memory for the JVM
```
java -Xmx2g -jar Picard/SamToFastq.jar I=SAMPLE.bam F=SAMPLE_R1.fastq F2=SAMPLE_R2.fastq
```

<http://broadinstitute.github.io/picard/command-line-overview.html#SamToFastq>

## bam2fastx

<http://manpages.ubuntu.com/manpages/quantal/man1/bam2fastx.1.html>

## Bedtools

```
bedtools bamtofastq -i input.bam -fq output.fastq
```

paired-end reads:
```
samtools sort -n input.bam -o input_sorted.bam   # sort reads by identifier-name (-n)
bedtools bamtofastq -i input_sorted.bam -fq output_R3.fastq -fq2 output_R2.fastq
```

<http://bedtools.readthedocs.org/en/latest/content/tools/bamtofastq.html>

## Bamtools

<http://github.com/pezmaster31/bamtools>
