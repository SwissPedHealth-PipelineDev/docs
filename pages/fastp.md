---
layout: default
title: FASTP
nav_order: 5
---

Last update: 20230727

{: .no_toc }
<details open markdown="block">
<summary>Table of contents</summary>
{: .text-delta }
- TOC
{:toc}
</details>

---

# FASTP
A tool designed to provide fast all-in-one preprocessing for FastQ files. 
It performs QC, checks adapters, trimming, filtering, splitting/merging, etc.
This tool is developed in C++ with multithreading supported to afford high performance.

* `fastp.sh` runs on every file in the raw data directory.
* Outputs the same directory structure with processed `.fq.gz` data.
* Checks for existing output before starting and therefore can run incrementally.
* Prints qulity reports to `.json` and `.html`.

## Links
* <https://github.com/OpenGene/fastp>
