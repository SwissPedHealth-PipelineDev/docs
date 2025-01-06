---
layout: default
title: PCA features
nav_order: 5
---

# Understanding the role and features of PCA in genetic analysis
Last update: 20250106

---

## Haplotype blocks

Consider how DNA is inherited from parents: during recombination, each chromosome in the nucleus - whether autosomal (chr1-22), sex (X, Y), or mitochondrial (Mt) - receives one DNA strand from each parent. 
These strands then break and exchange segments, resulting in a mix of parental DNA in the offspring, yet maintaining two copies of each chromosome.

<img src="{{ "assets/images/chronique_drouin_figure1.jpg" | relative_url }}" width="100%">

<img src="{{ "assets/images/chronique_drouin_figure2.jpg" | relative_url }}" width="100%">

Figure 1 and 2: Guy Drouin, Université d'Ottawa, for ACFAS.ca magazine.

As illustrated in Figure 1, each generation sees a number of "crossings" between our various heritages, at different points.
In this way, the intact or "non-recombining" pieces - the famous haplotypes - become smaller and smaller with each generation.
For example, figure 2 shows that the second copy of chromosome 2 contains an abnormally long haplotype. It is therefore a much more recent piece of chromosome than the others. In fact, this abnormally long haplotype represents a piece of chromosome that contains a useful variant. It enabled the person with this variant to survive better, and this person passed this variant on to his or her descendants. The more favorable a variant, the faster it spreads through the population.

## Haplotype blocks and genetic analysis

This recombination process creates long stretches of DNA, known as haplotype blocks, which are identical to those found in one parent or the other. By identifying a variant in a parent, one can track the same genetic block in the child, which will include the variant. This approach underlies methods like cheap genotyping and genome-wide association studies (GWAS), which focus on these blocks rather than individual genetic variants.

## The Function of PCA

As human populations have migrated and diversified, these haplotype blocks have mixed differently across regions, reflecting historical patterns of human movement. Principal Component Analysis (PCA) captures these differences in haplotype block distributions, correlating them with ancestral geographic origins. This is crucial for adjusting genetic studies for population stratification, ensuring that associations found are due to genetics and not population bias.

<img src="{{ "assets/images/wang_pca.png" | relative_url }}" width="100%">

Figure 3, from: 
Wang C, Zöllner S, Rosenberg NA (2012) A Quantitative Comparison of the Similarity between Genes and Geography in Worldwide Human Populations. PLOS Genetics 8(8): e1002886. <https://doi.org/10.1371/journal.pgen.1002886>

## Expectations in specific genetic conditions

For conditions like cystic fibrosis (deficiency in cystic fibrosis transmembrane conductance regulator, CFTR), where the most common known causes of disease are due to a variant that is inherited rather than spontaneous, PCA is expected reveal clustering within certain population groups, attributed to shared ancestral lineages. 
By default, cases with a shared variant are likely to cluster together in population groups because their DNA recombinations will have shared lineages (including the variant of interest _AND_ all of the other blocks of the genome). 
Otherwise, they would not have inherited the block of DNA containing this variant.
This is opposed to spontaneous variants, which appear independently of ancestral haplotypes and are unrelated to the distribution patterns PCA might reveal.

## Comparison  with viral genetics

Human genetics is generally more complex than viral genomes which depend on asexual reproduction. 
However, parallels can be drawn with viral genetics, where tracking variants is often more straightforward due to less genetic diversity compared to humans.

This screenshot from [Nextstrain Viral Epidemiology](https://nextstrain.org/mpox/all-clades) shows the clade of viruses across their genetic tree and physical location. 
In this case, the complication of recombination is removed and we simply have direct clonal descent and some spontaneous variants occuring. 

<img src="{{ "assets/images/nextstrain_screen.png" | relative_url }}" width="100%">

Figure 4: Screenshot of Nexstrain - Genomic epidemiology of mpox viruses across clades
Data updated 2025-01-04. Enabled by data from GenBank.
Showing 549 of 549 genomes.

## Analysis for unknown variants

Generally, association testing is focused on finding some shared genetic feature among affected patients. 
PCA is used to remove the background noise of benign haplotype blocks which are shared by inheritance.
Some unique patterns belong to different population groups which would otherwise appear as if they are related to disease.
After correcting for population structure with PCA, we hope to ignore those false positives and only identify variants that are truly associated (i.e. potentially causal) with disease.
Our intention is that this association will subsequently give was to causal inference with additional analysis. 
