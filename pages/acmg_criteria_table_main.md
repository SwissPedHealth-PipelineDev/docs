---
layout: default
title: ACMG criteria
nav_order: 5
---

Last update: 20220131
Last update: 20241205

{: .no_toc }
<details open markdown="block">
<summary>Table of contents</summary>
{: .text-delta }
- TOC
{:toc}
</details>

---

# Interpretation of variants by ACMG standards and guidelines


## Classification criteria

Extensive annotation is applied during our genomics analysis.
Interpretation of genetic determinants of disease is based on many evidence sources.
One important source of interpretation comes from the
_Standards and guidelines for the interpretation of sequence variants: a joint consensus recommendation of the American College of Medical Genetics and Genomics and the Association for Molecular Pathology_, Richards et al.
[^richards2015standards].
See also Li et al., 2017 [^li2017standards] and Riggs et al., 2020 [^riggs2020technical].
The following tables are provided as they appear in the initial steps of our filtering protocol for the addition of ACMG-standardised labels to candidate causal variants.

For reference, alternative public implementations of ACMG guidelines can be found in 
Li et al., 2017
[^li2017intervar] and
Xavier et al., 2019
[^xavier2019tapes];
please note these tools have not implemented here nor is any assertion of their quality offered.
Examples of effective variant filtering and expected candidate variant yield in studies of rare human disease are provided by
Pedersen et al., 2021
[^pedersen2021effective].

### Main criteria for classifications

{% include acgm_criteria_table.txt %}

### Caveats implementing filters

Implementing the guidelines for interpretation of annotation requires multiple programmatic steps. 
The number of individual caveat checks indicate the number of bioinformatic filter functions used.
Unnumbered caveat checks indicate that only a single filter function is required during reference to annotation databases.
However, each function depends on reference to either one or several evidence source databases (approximately 150 sources) which are not shown here. 

{% include acgm_criteria_table_caveats.txt %}

## Scoring point system

**Table 3** from Tavtigian et al. 2020 table 2 [^tavtigian2020fitting]: Point values for ACMG/AMP strength of evidence categories

| Evidence      | Point scale    | Pathogenic | Benign |
|---------------|----------------|------------|--------|
| Indeterminate | 0              | 0          | 0a     |
| Supporting    | 1              | 1          | -1     |
| Moderate      | 2              | 2          | -2b    |
| Strong        | 4              | 4          | -4     |
| Very strong   | 8              | 8          | -8b    |

a Note is made that [Richards et al.](#ref1) did not specifically recognize indeterminate evidence. Nonetheless, if one thinks of the odds in favor of pathogenicity as a continuous variable, there exists a range that falls between Supporting Benign and Supporting Pathogenic. This is Indeterminate.

b Note is also made that [Richards et al.](#ref1) did not specify benign evidence at the moderate or very strong levels. Nevertheless, the point system would readily support the addition of such criteria.

**Table 4**. from Tavtigian et al. 2020 table 2 [^tavtigian2020fitting]: Point-based variant classification categories

| Category         | Point ranges    | Notes |
|------------------|-----------------|-------|
| Pathogenic       | ≥10             |       |
| Likely Pathogenic| 6 to 9a         |       |
| Uncertain        | 0 to 5          |       |
| Likely Benign    | −1 to −6a       |       |
| Benign           | ≤ −7            |       |

a Operationally, the prior probability should be understood to be infinitesimally >0.10. This has two effects. First, it makes the posterior probability of the American College of Medical Genetics (ACMG) Likely Pathogenic combining rules infinitesimally greater than 0.90, so that the Likely Pathogenic rules work properly. A specific value of 0.102 would have the added benefit that seven points would meet the IARC (International Agency for Research on Cancer) Likely Pathogenic threshold of 0.95. Second, it enforces a requirement for some evidence of benign effect for sequence variants to be classified as Likely Benign. One could also argue that the point threshold for Likely Benign should really be −2. This would match the ACMG rule “Likely Benign (ii)” rather than the simple numerical requirement that the posterior probability be <0.10.

For reference, alternative public implementations of ACMG guidelines can be found in [Li & Wang, 2017](#ref3) and [Xavier et al., 2019](#ref4); please note these tools have not been implemented here nor is any assertion of their quality offered. Examples of effective variant filtering and expected candidate variant yield in studies of rare human disease are provided by [Pedersen et al., 2021](#ref5).

We use the evaluation of in silico predictors from Varsome. 
However, this paper discusses it also Wilcox et al., 2022 [^wilcox2022evaluating].


## ACMGuru code example 

The code from ACMGuru runs these runs using a range of functions and then performs a final tally.
Some excerts from the code are shown here:

```
# acmg_filters ----
# PVS1 ----
# PVS1 are null variants where IMPACT=="HIGH" and inheritance match, 
# in gene where LoF cause disease.
df$ACMG_PVS1 <- NA
df <- df %>% dplyr::select(ACMG_PVS1, everything())
df$ACMG_PVS1 <- ifelse(df$IMPACT == "HIGH" & 
                        df$genotype == 2, "PVS1", NA) # homozygous
df$ACMG_PVS1 <- ifelse(df$IMPACT == "HIGH" & 
                        df$Inheritance == "AD", "PVS1", df$ACMG_PVS1) # dominant

# All functions for classification ...

# acmg tally  ----
# List of all ACMG labels
# acmg_labels <- c("ACMG_PVS1", "ACMG_PS1", "ACMG_PS2", "ACMG_PS3", 
"ACMG_PS4", "ACMG_PS5", "ACMG_PM1", "ACMG_PM2", 
"ACMG_PM3", "ACMG_PM4", "ACMG_PM5", "ACMG_PM6", 
"ACMG_PM7", "ACMG_PP1", "ACMG_PP2", "ACMG_PP3", 
"ACMG_PP4")

# Transform 'Evidence_type' to 'P' for pathogenic and 'B' for benign
df_acmg$code_prefix <- ifelse(df_acmg$Evidence_type == "pathogenicity", "P", "B")

# Create the ACMG code by combining the new prefix and the label, prepending 'ACMG_'
df_acmg$ACMG_code <- paste0("ACMG_", df_acmg$code_prefix, df_acmg$label)

acmg_labels <- df_acmg$ACMG_code
print(acmg_labels)

# df_acmg$ACMG_label
names(df) |> head(30) |> as.character()

# Check if each ACMG column exists, if not create it and fill with NA
for (acmg_label in acmg_labels) {
  if (!acmg_label %in% names(df)) {
      print("missing label")
          df[[acmg_label]] <- NA
            }
            }

# Then use coalesce to find the first non-NA ACMG label
df$ACMG_highest <- dplyr::coalesce(!!!df[acmg_labels])
df <- df %>% dplyr::select(ACMG_highest, everything())

# Count the number of non-NA values across the columns
df$ACMG_count <- rowSums(!is.na(df[, acmg_labels ]))
df <- df %>% dplyr::select(ACMG_count, everything())
# df$ACMG_count[df$ACMG_count == 0] <- NA

# ACMG Verdict----
# Define scores for Pathogenic criteria
pathogenic_scores <- c(
 "PVS1" = 8,
  setNames(rep(4, 5), paste0("PS", 1:5)),
    setNames(rep(2, 7), paste0("PM", 1:7)),
      "PP3" = 1
      )

      # Define scores for Benign criteria
      benign_scores <- c(
        "BA1" = -8,
          setNames(rep(-4, 5), paste0("BS", 1:5)),
            setNames(rep(-1, 8), paste0("BP", 1:8))
            )

            # Combine both scoring systems into one vector
            acmg_scores <- c(pathogenic_scores, benign_scores)

            # Print the complete ACMG scoring system
            print(acmg_scores)

            # Create ACMG_score column by looking up ACMG_highest in acmg_scores
            df$ACMG_score <- acmg_scores[df$ACMG_highest]

# If there are any ACMG labels that don't have a corresponding score, 
# these will be NA. You may want to set these to 0.
df$ACMG_score[is.na(df$ACMG_score)] <- 0
df <- df |> dplyr::select(ACMG_score, everything())

# Total ACMG score ----

# Mutate all ACMG columns
df <- df %>% 
  mutate_at(acmg_labels, function(x) acmg_scores[x])

# Replace NAs with 0 in ACMG columns only
df[acmg_labels] <- lapply(df[acmg_labels], function(x) ifelse(is.na(x), 0, x))

# Calculate total ACMG score
df$ACMG_total_score <- rowSums(df[acmg_labels])

df <- df |> dplyr::select(ACMG_total_score, everything())
```

## References

[^richards2015standards]: Richards, S. et al., 2015. Standards and guidelines for the interpretation of sequence variants: a joint consensus recommendation of the American College of Medical Genetics and Genomics and the Association for Molecular Pathology. _Genetics in Medicine_, 17(5), pp.405–423. DOI: [10.1038/gim2015.30](https://www.gimjournal.org/article/S1098-3600(21)03031-8/fulltext).

[^li2017standards]: Li, M.M. et al., 2017. Standards and guidelines for the interpretation and reporting of sequence variants in cancer: a joint consensus recommendation of the Association for Molecular Pathology, American Society of Clinical Oncology, and College of American Pathologists. _The Journal of Molecular Diagnostics_, 19(1), pp.4–23. DOI: [10.1016/j.jmoldx.2016.10.002](https://doi.org/10.1016/j.jmoldx.2016.10.002).

[^riggs2020technical]: Riggs, E.R. et al., 2020. Technical standards for the interpretation and reporting of constitutional copy-number variants: a joint consensus recommendation of the American College of Medical Genetics and Genomics (ACMGe and the Clinical Genome Resource (ClinGen). _Genetics in Medicine_, 22(2), pp.245–257. DOI: [10.1038/s41436-019-0686-8](https://doi.org/10.1038/s41436-019-0686-8).

[^tavtigian2020fitting]: Tavtigian SV, Harrison SM, Boucher KM, Biesecker LG. (2020). Fitting a naturally scaled point system to the ACMG/AMP variant classification guidelines. *Human Mutation*, 41, 1734–1737. [https://doi.org/10.1002/humu.24088](https://doi.org/10.1002/humu.24088)

[^wilcox2022evaluating]: Emma H. Wilcox, Mahdi Sarmady, Bryan Wulf, Matt W. Wright, Heidi L. Rehm, Leslie G. Biesecker, Ahmad N. Abou Tayoun. (2022). Evaluating the impact of in silico predictors on clinical variant classification. *Genetics in Medicine*, Volume 24, Issue 4, Pages 924-930, ISSN 1098-3600, [https://doi.org/10.1016/j.gim.2021.11.018](https://doi.org/10.1016/j.gim.2021.11.018).

[^pedersen2021effective]: Pedersen, B.S. et al., 2021. Effective variant filtering and expected candidate variant yield in studies of rare human disease. _NPJ Genomic Medicine_, 6(1), pp.1–8. DOI: [10.1038/s41525-021-00227-3](https://doi.org/10.1038/s41525-021-00227-3).

[^li2017intervar]: Li, Q. and Wang, K., 2017. InterVar: clinical interpretation of genetic variants by the 2015 ACMG-AMP guidelines. _The American Journal of Human Genetics_, 100(2), pp.267–280. DOI: [10.1016/j.ajhg.2017.01.004](https://doi.org/10.1016/j.ajhg.2016.12.00://doi.org/10.1016/j.ajhg.2017.01.004).

[^xavier2019tapes]: Xavier, A. et al., 2019. TAPES: A tool for assessment and prioritisation in exome studies. _PLoS Computational Biology_, 15(10), e1007453. DOI: [10.1371/journal.pcbi.1007453](https://doi.org/10.1371/journal.pcbi.1007453).

