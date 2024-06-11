---
layout: default
title: Read group
date: 2024-06-11 00:00:01
nav_order: 5
---

Last update: 20240611


<!-- {: .no_toc } -->
<!-- <details open markdown="block"> -->
<!-- <summary>Table of contents</summary> -->
<!-- {: .text-delta } -->
<!-- - TOC -->
<!-- {:toc} -->
<!-- </details> -->
<!-- --- -->

This concept of "read groups" in sequencing data described here is copied from the GATK documentation by Derek Caetano-Anolles:
<https://gatk.broadinstitute.org/hc/en-us/articles/360035890671-Read-groups>.

You may be intersting in using this while doing [aggregate multiplex](aggregate_multiplex.html).

**Understanding Read Groups in Sequencing Data**

**Definition**: A 'read group' is a collection of reads from a single run of a sequencing instrument. In simpler setups where one library preparation from a biological sample is run on a single lane, all reads from that lane constitute a read group. In more complex cases involving multiplexing, each subset of reads from separate library preparations run on the same lane forms distinct read groups.

**Identification**: Read groups are identified by specific tags in the SAM/BAM/CRAM file, defined in the official SAM specification. These tags include:
- **ID**: Read group identifier, unique per read group, referenced in the read record and often based on the flowcell and lane.
- **PU**: Platform Unit, captures information about the flowcell barcode, lane, and sample barcode.
- **SM**: Sample name, indicating the sample sequenced in the read group.
- **PL**: Platform used, such as ILLUMINA or PACBIO.
- **LB**: DNA preparation library identifier.

**Importance**: Proper assignment of these tags is crucial for differentiating samples and mitigating technical artifacts during data processing steps like duplicate marking and base recalibration.

**Example Usage**:
- To view read group information in a BAM file:
  ```
  samtools view -H sample.bam | grep '^@RG'
  ```
  This command extracts lines starting with `@RG` from the BAM header, revealing the read group details.

**Example Read Group Fields**:
```
@RG ID:H0164.2 PL:illumina PU:H0164ALXX140820.2 LB:Solexa-272222 SM:NA12878
```
- **ID**: H0164.2 (flowcell and lane)
- **PU**: H0164ALXX140820.2 (flowcell, lane, and sample barcode)
- **LB**: Solexa-272222 (library identifier)
- **SM**: NA12878 (sample name)
- **PL**: illumina (sequencing platform)

**Multi-sample and Multiplexed Example**:
For a trio of samples (MOM, DAD, KID) with two libraries each (200 bp and 400 bp inserts), and each library sequenced across two lanes, the read group tags in the headers might appear as follows:

- **Dad’s Data**:
  ```
  @RG ID:FLOWCELL1.LANE1 PL:ILLUMINA LB:LIB-DAD-1 SM:DAD PI:200
  @RG ID:FLOWCELL1.LANE2 PL:ILLUMINA LB:LIB-DAD-1 SM:DAD PI:200
  @RG ID:FLOWCELL1.LANE3 PL:ILLUMINA LB:LIB-DAD-2 SM:DAD PI:400
  @RG ID:FLOWCELL1.LANE4 PL:ILLUMINA LB:LIB-DAD-2 SM:DAD PI:400
  ```
- **Mom’s and Kid's Data** similarly detailed.

**Conclusion**: Understanding and correctly implementing read group information is critical for high-quality genomic data processing, helping distinguish between various technical and biological factors that affect sequencing outcomes.

