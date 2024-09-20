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


# Variant features to RDF concept metadata

This page outlines the process of preparing and validating variants against specific RDF structure data concepts. 
Prior to this step, whole genome sequence data will have been processed and filtered to identify clinically actionable genetic variants.
Resulting omic output can then be reported back with accurate integration into clinical data warehouses.
The following example is equivalent to a subset of real output available in production.

{: .note }
This document is to be updated as we improve the `metadata_descriptions` step which is critical so that downstream users can correctly map data.


## Checklist

1. Do we have all necessary variant descriptors in the example? 
2. Do we have all necessary metadata explanations such as cardinality?
3. Are the metadata explanations correct based on the SPHN omic concepts?
4. Downstream users (mapping) can choose from TSV, HTML, JSON, and Rds. Any others needed?


## Output example

The following table is the output of this process.

{% include example_variant_enhanced.html %}

1. Our WGS pipleine includes variant descriptor columns.
2. We add additional metadata column to help with mapping.

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

## Downloads

Example outputs can be downloaded from the public set.
Each link points to the file within the GitHub repository.

| File Name                        | Download Link                                                                                                   |
|----------------------------------|-----------------------------------------------------------------------------------------------------------------|
| `example_variant.Rds`            | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/example_variant.Rds)          |
| `example_variant.tsv`            | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/example_variant.tsv)          |
| `example_variant_enhanced.Rds`   | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/example_variant_enhanced.Rds) |
| `example_variant_enhanced.html`  | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/example_variant_enhanced.html)|
| `example_variant_enhanced.json`  | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/example_variant_enhanced.json)|
| `example_variant_enhanced.tsv`   | [Download](https://github.com/SwissPedHealth-PipelineDev/docs/tree/main/_includes/example_variant_enhanced.tsv) |


## Variant Extraction
The first script gathers example variants and extracts key columns necessary for reporting a genetic variant as a cause of disease.
Script Location
`./src/1_get_example_variant.R`

```R
library(dplyr)

# This block reads some example variants from a project ----
geneset_MCL_ID <- c(22, 586)
df_report_main_text <- readRDS(file=paste0("~/examples/ACMGuru_post_ppi/df_report_main_text_", paste(geneset_MCL_ID, collapse="_"), ".Rds"))

names(df_report_main_text)
# > names(df_report_main_text)
# [1] "sample.id"        "ACMG_total_score" "ACMG_count"       "ACMG_highest"    
# [5] "rownames"         "CHROM"            "REF"              "ALT"             
# [9] "POS"              "start"            "end"              "width"           
# [13] "Gene"             "SYMBOL"           "HGNC_ID"          "HGVSp"           
# [17] "HGVSc"            "Consequence"      "IMPACT"           "genotype"        
# [21] "Feature_type"     "Feature"          "BIOTYPE"          "VARIANT_CLASS"   
# [25] "CANONICAL"        "Inheritance"      "CLIN_SIG"         "gnomAD_AF"       
# [29] "comp_het_flag"    "Strong_patho"     "Moder_patho"      "Suppor_patho"  

# select features ----
df_report_set <- df_report_main_text |> 
	dplyr::select(sample.id, rownames, 
					  CHROM, REF, ALT, 
					  POS, start, end, width, 
					  Gene, SYMBOL, HGNC_ID, 
					  HGVSp, HGVSc, Consequence, 
					  IMPACT, genotype,
					  Feature_type, Feature, BIOTYPE, VARIANT_CLASS, CANONICAL,
	) |> 
	filter(IMPACT == "HIGH") |>
	head(3)

df_report_set |> names()

# set example sample.id ----
df_report_set$sample.id <- "Canton_001"

# save example variant as Rds and as TSV ----
output_directory <- "../data/"
saveRDS(df_report_set, file=paste0(output_directory, "example_variant.Rds"))
write.table(df_report_set, file=paste0(output_directory, "example_variant.tsv"), sep = "\t")
```

## Mapping to Metadata

The second script enhances the output from the first script by appending metadata to facilitate mapping to RDF concepts.

Script Location `./src/2_variant_to_meta.R`

```R
library(dplyr)
library(knitr)
library(kableExtra)
library(jsonlite)

# Define the key columns for genetic variation concepts ----
key_columns <- c("CHROM", "POS", "REF", "ALT")
key_metadata <- paste(key_columns, "Metadata", sep = "_")

# Enhance dataframe with visible metadata columns for easy reference -----
df_enhanced <- df_report_set %>%
	mutate(
		CHROM_Metadata = "Type: Chromosome; Cardinality: 1:1; Value Set: SNOMED CT: 91272006, LOINC:48000-4",
		POS_Metadata = "Type: Genomic Position; Cardinality: 1:1; Value Set: GENO:0000902",
		REF_Metadata = "Type: Reference Allele; Cardinality: 1:1; Value Set: string",
		ALT_Metadata = "Type: Alternate Allele; Cardinality: 1:1; Value Set: string"
	)

# Generate footnotes dynamically based on key metadata columns ----
metadata_descriptions <- c(
	"CHROM_Metadata" = "Metadata for CHROM column: Type: Chromosome, Cardinality: 1:1, Value Set: SNOMED CT: 91272006, LOINC:48000-4",
	"POS_Metadata" = "Metadata for POS column: Type: Genomic Position, Cardinality: 1:1, Value Set: GENO:0000902",
	"REF_Metadata" = "Metadata for REF column: Type: Reference Allele, Cardinality: 1:1, Value Set: string",
	"ALT_Metadata" = "Metadata for ALT column: Type: Alternate Allele, Cardinality: 1:1, Value Set: string"
)

# Create the HTML table with footnotes for metadata ----
table_html <- df_enhanced %>%
	kable("html", escape = FALSE) %>%
	kable_styling(
		bootstrap_options = c("striped", "hover", "condensed"), 
		full_width = FALSE,
		font_size = 14, 
		position = "left"
	) %>%
	column_spec(1, bold = TRUE) %>% 
	row_spec(0, bold = TRUE, background = "#D3D3D3", color = "black") %>% 
	# add_header_above(c(" " = 1, "Genetic Variation Info" = 4)) %>% 
	scroll_box(width = "100%", height = "500px") 

# Apply red color to key columns and their metadata ----
for (col in key_columns) {
	col_index <- which(names(df_enhanced) == col)
	table_html <- table_html %>%
		column_spec(col_index, color = "red", bold = TRUE)
}

# Adding footnotes for key metadata columns ----
table_html <- table_html %>%
	footnote(
		general = metadata_descriptions[key_metadata],
		general_title = "Key Metadata Descriptions",
		symbol = "*"
	)

# Save the HTML table to a file -----
output_directory <- "../data/"
file_html <- paste0(output_directory, "example_variant_enhanced.html")
writeLines(as.character(table_html), file_html)

# Convert the enhanced dataframe to JSON format ----
table_json <- toJSON(df_enhanced, pretty = TRUE)
file_json <- paste0(output_directory, "example_variant_enhanced.json")
writeLines(table_json, file_json)

# Optionally, open the HTML file in the default system browser ----
if (Sys.info()["sysname"] == "Windows") {
	shell(paste("start", file_html))
} else {
	system(paste("open", file_html))
}

# Print completion messages
cat("The HTML table has been generated and saved successfully.\n")
cat("The JSON data has been generated and saved successfully.\n")

# save as a Rds and TSV file ----
saveRDS(df_enhanced, file=paste0(output_directory, "example_variant_enhanced.Rds"))
write.table(df_enhanced, file=paste0(output_directory, "example_variant_enhanced.tsv"), sep = "\t")
```
