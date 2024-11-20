
## WGS data
## Phase 1

FASTQ files were previously pre-processed to BAM and VCF files (Ibarth 2030gc). 
`fastq (raw read data) -> bam (aligned to genome) -> vcf (variants detected)`

* VCF - 204 samples
* BAM files - 229 samples

```
enable_modules
module load bcftools
bcftools query -l variantcalls/MMA_PHRT_D.hg19.joint.genotyped.vcf | wc -l
204
ls bams/*bam | wc -l
229
```

Option - reverting 229 bam files to fastq and run again with phase 2 pipeline. 
<https://bedtools.readthedocs.io/en/latest/content/tools/bamtofastq.html>


rna/bams/*bam | wc -l
221

 rna/fastq/*r1.fq.gz | wc -l
221
