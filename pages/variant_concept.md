---
layout: default
title: Variant to RDF concept
nav_order: 5
---

Last update: 20240920

{: .no_toc }
<details open markdown="block">
<summary>Table of contents</summary>
{: .text-delta }
- TOC
{:toc}
</details>


<!--  (curly) (percent symbol)  include example_variant_enhanced.html (percent symbol) (curly) -->


# Variant features to RDF concept metadata

{: .note }
This process is starting with `sequencing_assay`, which includes `library_preparation`, `sequencing_run`, etc. We will continue through the pipeline until we reach the final end-point required to report a pathogenic variant. 

This documentation outlines the transformation of variant information from whole genome sequence (WGS) data to a format adhering to RDF structure data concepts. 
The aim is to ensure that the omic output from genomic analyses can be seamlessly integrated into clinical data warehouses with high fidelity and clarity.

**Number of variables**:
- All SPHN RDF concept info (see `SPHN_dataset_release_2024_2_20240502.xlsx`) = 1503
- Subset of relevant concepts = 76 (see `example_subset_concepts.tsv`)
- Relevant WGS pipeline logs = 62 (see `example_report.tsv`)
- Currently automated match = 13 (see `example_report_concepts.Rds`)

    {: .note }
This repository uses a public dataset of example genetic variants and sequencing/analysis log data.


## Overview

The process begins with the extraction of variant data from a genomic study, (no sensitive data is included in the public example set).
The key variant features such as Chromosome (CHROM), Position (POS), Reference Allele (REF), and Alternate Allele (ALT) are formatted alongside metadata that describes their relationship to RDF concepts. 
This ensures downstream users can map these data accurately within clinical and research frameworks.

{: .note }
This document is to be updated as we improve the linking of result terms to `SPHN_dataset_release_2024_2_20240502.xlsx` which is critical so that downstream users can correctly map data.

## Aims

1. **Data preparation**: Start with the extracted variant information from the genomic pipeline.
2. **Key term identification**: Focus on essential genomic terms like CHROM, POS, REF, and ALT, Sequencing run, Sequencing instrument.
3. **Metadata addition**: Attach metadata columns that specify RDF concept requirements such as type and cardinality.
4. **Validation checklist**:
	- Do we have all necessary variant descriptors present?
	- Is there inclusion and accuracy of all metadata explanations?
	- Is there alignment of metadata with SPHN omic concepts?
	- Downstream users (mapping) can choose from TSV, HTML, JSON, and Rds. Any others needed?

## Current version

The observation column is highlighted in GREEN. 
It contains the data which we report as output from the pipeline for use in our database 
Here is the completed concept observations (this is file  `example_report_concepts.html`):

{% include concept/out/example_report_concepts.html %}

## Semantic evidence network

I have added the following method to automatically plot semantic evidence networks which show how evidence provenance has been generated.
The dataset is organised into three hierarchical grouping levels based on the column `concept_or_concept_compositions_or_inherited`. 
The top level, Level 1, includes entries where this column equals "concept". 
The subsequent levels, Level 2 and Level 3, contain entries where this column does not equal "concept". 
The distinction between Levels 2 and 3 lies in the presence of distinct observations; Level 3 specifically represents the final observation associated with the general concept names from Level 2, differentiated further by non-empty values in the observation column, making Level 3 essentially a detailed continuation of Level 2.

 Nodes within the network are structured with the following attributes: `general_concept_name`, `id`, `group`, `name`, and `observation`, where `general_concept_name` recurs in both Level 2 and Level 3 but differs based on the associated observation. 
Edges within this hierarchical setup link nodes from Level 1 to Level 2 and from Level 2 to Level 3 using `general_concept_name` as a consistent link identifier, facilitating a connection between the initial abstract concept level and its more detailed observational breakdowns.

<img src="{{ "assets/images/plot_semantic_evidence_plot_network.png" | relative_url }}" width="100%">
<img src="{{ "assets/images/plot_semantic_evidence_plot_sankey.png" | relative_url }}" width="100%">

## Downloads

Example output (in mutiple filetypes) can be downloaded from the public set:

| File Name                      | Download Link                                                                                                       |
|--------------------------------|---------------------------------------------------------------------------------------------------------------------|
| `example_report_concepts.tsv`  | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/concept/out/example_report_concepts.tsv)  |
| `example_report_concepts.html`  | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/concept/out/example_report_concepts.html)  |
| `example_report_concepts.Rds`  | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/concept/out/example_report_concepts.Rds)  |
| `example_report_concepts.Rds`  | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/concept/out/example_report_concepts.Rds)  |
| `example_report_concepts.Rds`  | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/concept/out/example_report_concepts.Rds)  |
| `pdf plot_semantic_evidence_plot_network.pdf` |  [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/assets/images/plot_semantic_evidence_plot_network.pdf) |
| `pdf plot_semantic_evidence_plot_sankey.pdf`  |  [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/assets/images/plot_semantic_evidence_plot_sankey.pdf) |
| `html plot_semantic_evidence_plot_network.html` |  [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/assets/images/plot_semantic_evidence_plot_network.html) |
| `html plot_semantic_evidence_plot_sankey.html`  |  [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/assets/images/plot_semantic_evidence_plot_sankey.html) |


Example inputs can be downloaded from the public set:

| File Name                                                             | Download Link                                                                                                                                         |
|-----------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| `Canton_001_NGS000012345_NA_S46_L001_R1_001.fastq_head.text`          | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/Canton_001_NGS000012345_NA_S46_L001_R1_001.fastq_head.text)          |
| `Canton_001_NGS000012345_NA_S46_L001_R1_001_sample_seq_assay_log.text`| [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/Canton_001_NGS000012345_NA_S46_L001_R1_001_sample_seq_assay_log.text)|
| `SPHN_dataset_release_2024_2_20240502.xlsx`                           | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/SPHN_dataset_release_2024_2_20240502.xlsx)                           |
| `sequencing assay_van_der_Horst2023.txt`                              | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/sequencing_assay_van_der_Horst2023.txt)                              |
| `bwa_10351_101_10453.out.text`                                        | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/bwa_10351_101_10453.out.text)                                        |
| `example_variant.Rds`                                                 | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/example_variant.Rds)                                                 |
| `example_variant.tsv`                                                 | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/example_variant.tsv)                                                 |

## Process Steps for Variant Features to RDF Concept Mapping

This section outlines the sequential processing steps from data extraction through to the final merged dataset, prepared for RDF concept mapping. Each step corresponds to a specific script and handles distinct data types or stages in data preparation and merging.

1. **Export Variant Data from Study**
	- Extracts variant data from genomic projects focusing on specific genes and filtering for high-impact variants, saving them in formats like RDS and TSV for further processing.
2. **Read Variant Report Data**
	- Loads and transforms variant data into a long format to facilitate metadata annotation, preparing the data by adding a column for metadata requirements.
3. **Read Sequencing Assay Data**
	- Extracts key sequencing assay data such as identifiers, read depth, and file formats from logs or metadata files, providing crucial context for sequencing parameters.
4. **Read BWA Read Group Data**
	- Parses BWA and samtools log files to extract detailed read group information, including metadata about the sequencing run such as machine, file paths, and read group specifications.
5. **Read Fastq Header Data**
 	- Analyzes headers from FASTQ files to extract sequencing instrument details and run metrics, offering a granular look at the sequencing runs which is instrumental in validating sequencing quality and parameters.
6. **Merge Datasets**
	- Combines all processed data from the previous steps into a single dataset, aligning them by common identifiers and ensuring consistency across data types.
7. **Map Pipeline Output to SPHN Concepts**
	- Maps the merged dataset to standard SPHN RDF concepts, ensuring each data point is correctly classified according to standardized ontology, thus aligning detailed genomic data with broader healthcare data standards.

## Terms used in WGS logging

### Descriptions for sequencing assay (WGS) terms

| Column Name            | Description |
|------------------------|-------------|
| `seq_assay_identifier` | The unique identifier for the sequencing assay, typically a standard ontology term such as obo:OBI_002117 for Whole Genome Sequencing. |
| `seq_assay_intended_read_depth` | The targeted depth of coverage for the sequencing assay, indicating how many times each base is expected to be sequenced; in this case, 150x. |
| `seq_assay_intended_read_length` | The expected length of each read in the sequencing process, measured in base pairs; here, 20 bp. |
| `data_file_identifier` | Identifier for the data file output from the sequencing, used to trace and access the file within data systems. |
| `data_file_format` | The format of the sequencing data files, specifying the standard used; here, EDAM format 1931, which is typical for FASTQ files from Illumina platforms. |
| `quality_control_name` | The name of the metric used to assess the quality of the sequencing data; in this case, the Phred quality score. |
| `quality_control_value` | The actual quality score achieved, indicating the reliability of the sequencing reads; 78.33% in this context. |
| `library_prep_kit` | Specifies the kit used for preparing DNA libraries for sequencing, critical for understanding the sample preparation methodology; Illumina TruSeq DNA PCR-Free is noted for high fidelity. |
| `sample_identifier` | The unique identifier for the sample being sequenced, used for tracking and reference throughout the sequencing process. |
| `sample_material_type` | The type of biological material from which the sample was derived, with its specific ontology code; snomed:119297000 denotes a blood sample. |
| `seq_instrument_code` | The identifier for the sequencing instrument used, linking to specific equipment details; obo: OBI_0002630 refers to the Illumina NovaSeq 6000. |
| `sop_name` | The name of the Standard Operating Procedure followed during the sequencing, ensuring consistency and reproducibility; here, "WGS with Illumina NovaSeq 6000". |
| `sop_description` | A brief description of the SOP, providing context and specifics about the sequencing approach used. |
| `sop_version` | The version number of the SOP, which helps in identifying any changes or updates that might affect the sequencing output or interpretation. |

### Descriptions for FASTQ/BAM readgroup terms

| Column Name   | Description |
|---------------|-------------|
| `START AT`    | The start timestamp of the sequencing or analysis process. |
| `END AT`      | The end timestamp of the sequencing or analysis process. |
| `sample_read_id` | A unique identifier for each sample read in the process. |
| `rel_dir`     | Relative directory path where sequencing data is stored. |
| `dir_id`      | Directory identifier combining the project and sample ID. |
| `FILE1`       | Path to the first FASTQ file generated by sequencing. |
| `FILE2`       | Path to the second FASTQ file generated by sequencing. |
| `output_file` | Path to the final BAM file generated after processing. |
| `ID`          | Internal identifier used to track the sample in analysis. |
| `SM`          | Sample name or identifier used within the BAM file. |
| `PL`          | Sequencing platform used, indicating technology type. |
| `PU`          | Platform unit (PU) tag, often a barcode identifier. |
| `LB`          | Library ID which is crucial for distinguishing between libraries prepared differently. |
| `RG`          | Read group identifier in a BAM file, encapsulating all other identifiers. |

### Descriptions for genetic variants terms

| Column Name     | Description                                                                         |
|-----------------|-------------------------------------------------------------------------------------|
| `sample.id`     | Unique identifier for each sample.                                                  |
| `rownames`      | Row names corresponding to data entries.                                            |
| `CHROM`         | Chromosome number where the variant is located.                                     |
| `REF`           | Reference allele at the variant locus.                                              |
| `ALT`           | Alternate allele at the variant locus.                                              |
| `POS`           | Position of the variant on the chromosome.                                          |
| `start`         | Start position of the variant.                                                      |
| `end`           | End position of the variant.                                                        |
| `width`         | Width of the variant region.                                                        |
| `Gene`          | Gene name associated with the variant.                                              |
| `SYMBOL`        | Gene symbol.                                                                        |
| `HGNC_ID`       | HUGO Gene Nomenclature Committee ID.                                                |
| `HGVSp`         | Human Genome Variation Society protein nomenclature.                                |
| `HGVSc`         | Human Genome Variation Society coding DNA sequence nomenclature.                    |
| `Consequence`   | Consequence of the variant.                                                         |
| `IMPACT`        | Impact of the variant on the gene or protein function.                              |
| `genotype`      | Genotype showing the variant alleles.                                               |
| `Feature_type`  | Type of genomic feature (e.g., transcript, regulatory).                             |
| `Feature`       | Specific feature affected by the variant (e.g., exon, intron).                      |
| `BIOTYPE`       | Biological type of the feature affected (e.g., protein_coding, miRNA).              |
| `VARIANT_CLASS` | Classification of the variant based on its genomic context.                         |
| `CANONICAL`     | Indicates if the transcript is the canonical transcript.                            |
| `CHROM_Metadata`| Type: Chromosome; Cardinality: 1:1; Value Set: SNOMED CT: 91272006, LOINC:48000-4   |
| `POS_Metadata`  | Type: Genomic Position; Cardinality: 1:1; Value Set: GENO:0000902                   |
| `REF_Metadata`  | Type: Reference Allele; Cardinality: 1:1; Value Set: string                         |
| `ALT_Metadata`  | Type: Alternate Allele; Cardinality: 1:1; Value Set: string                         |

