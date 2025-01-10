---
layout: default
title: Panels disease gene
nav_order: 5
---

# Panels disease gene

Last update: 20241205

The main source of our panel data is from Genomics England panelapp
<https://panelapp.genomicsengland.co.uk>.
The PanelApp database includes all the gene panels that relate to genomic tests listed in the [NHS National Genomic Test Directory](https://www.england.nhs.uk/publication/national-genomic-test-directories), as well as the virtual gene panels that were used in the [100,000 Genomes Project](https://www.genomicsengland.co.uk/initiatives/100000-genomes-project).

We explicitly aim to develop methods that avoid the bias of virtual panel analysis. 
However, the knowledge of known disease-gene mechanisms are a valuable scoring feature in variant classification.

For example, ACMG variant classification standards include eight stages which use knowledge of genes with a known mechanism of disease.
These apply when classifying evidence related to both pathogenic or benign effects.
The affected ACGM criteria are:
PVS1, PS1, PM1, PP1,
BVS1, BS1, BM1, BP1.
A subsequent example is the ACMG classification step, PVS1, which is defined as a "null variant (nonsense, frameshift, canonical +- 2 splice sites, initiation codon, single or multiexon deletion) in a gene where LOF is a known mechanism of disease".
Thus to define a gene as beloging to a known disease meachnism we must use a stable and reliable soure of disease-genes. Read more here](acmg_criteria_table_main.html).



## Current usage

1. **Human Inborn Errors of Immunity**
    * File: `10876_2022_1289_MOESM2_ESM_DLcleaned.tsv`
    * Source: <https://lawlessgenomics.com/topic/iuis-iei-table-page> via International Union of Immunological Societies (IUIS) Inborn Errors of Immunity Committee (IEI) (<https://iuis.org>)
    * Caveat: [Cleaning was implemented here](https://github.com/DylanLawless/genomics_tools/tree/master/iuis_iei_table)

1. **Likely inborn error of metabolis**
    * File: `Likely_inborn_error_of_metabolism_targeted_testing_not_possible.tsv`
    * Source: <https://panelapp.genomicsengland.co.uk/panels/467/>
    * Caveat: None

1. **Pending: All 451 panels of GE panel app**
    * File: `Not shown`
    * Source: [GE panel app](https://panelapp.genomicsengland.co.uk) via the [API](https://panelapp.genomicsengland.co.uk/api/docs/)
    * Caveat: Login required - this database has been locally downloaded and processed for our pipelines.
