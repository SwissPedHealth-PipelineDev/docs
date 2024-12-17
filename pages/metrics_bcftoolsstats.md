---
layout: default
math: mathjax
title: Metrics Bcftools stats
nav_order: 5
---

Last update: 20241217

# Metrics Bcftools stats

Usage Example:
```
# Run bcftools stats
echo "--Generating stats for file: ${vcf}"
bcftools stats "${vcf}" > "${stats_out}"

# Run plot-vcfstats
echo "--Generating plots for stats of file: ${vcf}"
plot-vcfstats -p "${plot_out}" "${stats_out}"
```



We use this in our study book for:

1. `bcftools stats` and `plot-vcfstats`: `07c_qc_summary_stats.sh` -> `study_book/qc_summary_stats` gVCF summary after HC
