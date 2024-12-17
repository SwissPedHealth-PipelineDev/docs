---
layout: default
math: mathjax
title: Metrics CollectWgsMetrics
nav_order: 5
---

Last update: 20241217

# CollectWgsMetrics (Picard)
Collect metrics about coverage and performance of whole genome sequencing (WGS) experiments.
This tool collects metrics about the fractions of reads that pass base- and mapping-quality filters as well as coverage (read-depth) levels for WGS analyses. Both minimum base- and mapping-quality values as well as the maximum read depths (coverage cap) are user defined.
Note: Metrics labeled as percentages are actually expressed as fractions!
<https://gatk.broadinstitute.org/hc/en-us/articles/360037269351-CollectWgsMetrics-Picard>

Usage Example:
```
java -jar picard.jar CollectWgsMetrics \
       I=input.bam \
       O=collect_wgs_metrics.txt \
       R=reference_sequence.fasta 
```

We use this in our study book for:

1. `CollectWgsMetrics`: `03b_collectwgsmetrics.sh` ->  `study_book/qc_summary_stats` mapping, depth, and more. 


| Metric                | Summary                                                                                                                                                                           |
|-----------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| GENOME_TERRITORY      | The number of non-N bases in the genome reference over which coverage will be evaluated.                                                                                          |
| MEAN_COVERAGE         | The mean coverage in bases of the genome territory, after all filters are applied.                                                                                                |
| SD_COVERAGE           | The standard deviation of coverage of the genome after all filters are applied.                                                                                                   |
| MEDIAN_COVERAGE       | The median coverage in bases of the genome territory, after all filters are applied.                                                                                              |
| MAD_COVERAGE          | The median absolute deviation of coverage of the genome after all filters are applied.                                                                                            |
| PCT_EXC_ADAPTER       | The fraction of aligned bases that were filtered out because they were in reads with mapping quality 0 and looked like adapter reads.                                             |
| PCT_EXC_MAPQ          | The fraction of aligned bases that were filtered out because they were in reads with low mapping quality (lower than MIN_MAPPING_QUALITY).                                        |
| PCT_EXC_DUPE          | The fraction of aligned bases that were filtered out because they were in reads marked as duplicates.                                                                             |
| PCT_EXC_UNPAIRED      | The fraction of aligned bases that were filtered out because they were in reads without a mapped mate pair.                                                                       |
| PCT_EXC_BASEQ         | The fraction of aligned bases that were filtered out because they were of low base quality (lower than MIN_BASE_QUALITY).                                                         |
| PCT_EXC_OVERLAP       | The fraction of aligned bases that were filtered out because they were the second observation from an insert with overlapping reads.                                              |
| PCT_EXC_CAPPED        | The fraction of aligned bases that were filtered out because they would have raised coverage above COVERAGE_CAP.                                                                  |
| PCT_EXC_TOTAL         | The total fraction of aligned bases excluded due to all filters.                                                                                                                  |
| PCT_1X                | The fraction of bases that attained at least 1X sequence coverage in post-filtering bases.                                                                                        |
| PCT_5X                | The fraction of bases that attained at least 5X sequence coverage in post-filtering bases.                                                                                        |
| PCT_10X               | The fraction of bases that attained at least 10X sequence coverage in post-filtering bases.                                                                                       |
| PCT_15X               | The fraction of bases that attained at least 15X sequence coverage in post-filtering bases.                                                                                       |
| PCT_20X               | The fraction of bases that attained at least 20X sequence coverage in post-filtering bases.                                                                                       |
| PCT_25X               | The fraction of bases that attained at least 25X sequence coverage in post-filtering bases.                                                                                       |
| PCT_30X               | The fraction of bases that attained at least 30X sequence coverage in post-filtering bases.                                                                                       |
| PCT_40X               | The fraction of bases that attained at least 40X sequence coverage in post-filtering bases.                                                                                       |
| PCT_50X               | The fraction of bases that attained at least 50X sequence coverage in post-filtering bases.                                                                                       |
| PCT_60X               | The fraction of bases that attained at least 60X sequence coverage in post-filtering bases.                                                                                       |
| PCT_70X               | The fraction of bases that attained at least 70X sequence coverage in post-filtering bases.                                                                                       |
| PCT_80X               | The fraction of bases that attained at least 80X sequence coverage in post-filtering bases.                                                                                       |
| PCT_90X               | The fraction of bases that attained at least 90X sequence coverage in post-filtering bases.                                                                                       |
| PCT_100X              | The fraction of bases that attained at least 100X sequence coverage in post-filtering bases.                                                                                      |
| FOLD_80_BASE_PENALTY  | The fold over-coverage necessary to raise 80% of bases to the mean coverage level.                                                                                                |
| FOLD_90_BASE_PENALTY  | The fold over-coverage necessary to raise 90% of bases to the mean coverage level.                                                                                                |
| FOLD_95_BASE_PENALTY  | The fold over-coverage necessary to raise 95% of bases to the mean coverage level.                                                                                                |
| HET_SNP_SENSITIVITY   | The theoretical HET SNP sensitivity.                                                                                                                                              |
| HET_SNP_Q             | The Phred Scaled Q Score of the theoretical HET SNP sensitivity.                                                                                                                  |

