---
layout: default
math: mathjax
title: VCF - Variant Call Format
nav_order: 5
---

Last update: 20241214

<hr>

# VCF - Variant Call Format

{: .note }

This page has been directly cloned from  `GATK / Technical Documentation / Glossary`
<https://gatk.broadinstitute.org/hc/en-us/articles/360035531692-VCF-Variant-Call-Format>.
Please check the original source if it is available for updates.
The VCF specifications can be read directly from the original documentation. However, this page is very useful and is thus preserved here for reference.


* GATK Team
* June 25, 2024 08:15 Updated


<h3>Contents</h3>

<ol>
<li>Overview</li>
<li>Structure of a VCF file</li>
<li>Interpreting the header information</li>
<li>Structure of variant call records</li>
<li>Interpreting genotype and other sample-level information  </li>
<li>Basic operations: validating, subsetting and exporting from a VCF</li>
<li>Merging VCF files</li>
</ol>

<hr>

<h2>1. Overview</h2>

<p>VCF, or <em>Variant Call Format</em>, It is a standardized text file format used for representing SNP, indel, and structural variation calls. The VCF specification used to be maintained by the 1000 Genomes Project, but its management and further development has been taken over by the <a href="https://www.ga4gh.org/genomic-data-toolkit/">Genomic Data Toolkit</a> team of the <a href="http://ga4gh.org">Global Alliance for Genomics and Health</a>.</p>

<p>The full format spec can be found in the <a href="http://samtools.github.io/hts-specs">Samtools/Hts-specs repository</a>, along with other useful specifications like SAM/BAM/CRAM. We highly encourage you to take a look at those documents, as they contain a lot of useful information that we do not go over in this document.</p>

<p>VCF is the primary (and only well-supported) format used by the GATK for variant calls. We prefer it above all others because while it can be a bit verbose, the VCF format is <strong>very explicit</strong> about the exact type and sequence of variation as well as the genotypes of multiple samples for this variation.  </p>

<p>That being said, this highly detailed information can be challenging to understand. The information provided by the GATK tools that infer variation from high-throughput sequencing data, such as the HaplotypeCaller, is especially complex. This document describes the key features and annotations that you need to know about in order to understand VCF files output by the GATK tools.</p>

<p>Note that VCF files are plain text files, so you can open them for viewing or editing in any text editor, with the following caveats:</p>

<ul>
<li><p>Some VCF files are <strong>very large</strong>, so your personal computer may struggle to load the whole file into memory. In such cases, you may need to use a different approach, such as using UNIX tools to access the part of the dataset that is relevant to you, or subsetting the data using tools like GATK's SelectVariants.</p></li>
<li><p><strong>NEVER EDIT A VCF IN A WORD PROCESSOR SUCH AS MICROSOFT WORD BECAUSE IT WILL SCREW UP THE FORMAT!</strong> You have been warned :)</p></li>
<li><p>Do not write home-brewed VCF parsing scripts — it never ends well.  </p></li>
</ul>

<hr>

<h2>2. Structure of a VCF file</h2>

<p>A valid VCF file is composed of two main parts: the header, and the variant call records.</p>

<p><img src="https://drive.google.com/uc?id=12GG0jSpXbFsP8Re39aQnjJTLdNhmFCZV" alt=""></p>

<p>The header contains information about the dataset and relevant reference sources (e.g. the organism, genome build version etc.), as well as definitions of all the annotations used to qualify and quantify the properties of the variant calls contained in the VCF file. The header of VCFs generated by GATK tools also include the command line that was used to generate them. Some other programs also record the command line in the VCF header, but not all do so as it is not required by the VCF specification. For more information about the header, see the next section.</p>

<p>The actual data lines will look something like this:</p>


<div class="table-wrapper" markdown="block">
<pre>[HEADER LINES]
#CHROM  POS ID      REF ALT QUAL    FILTER  INFO          FORMAT          NA12878
20  10001019    .   T   G   364.77  .   AC=1;AF=0.500;AN=2;BaseQRankSum=0.699;ClippingRankSum=0.00;DP=34;ExcessHet=3.0103;FS=3.064;MLEAC=1;MLEAF=0.500;MQ=42.48;MQRankSum=-3.219e+00;QD=11.05;ReadPosRankSum=-6.450e-01;SOR=0.537   GT:AD:DP:GQ:PL  0/1:18,15:33:99:393,0,480
20  10001298    .   T   A   884.77  .   AC=2;AF=1.00;AN=2;DP=30;ExcessHet=3.0103;FS=0.000;MLEAC=2;MLEAF=1.00;MQ=60.00;QD=29.49;SOR=1.765    GT:AD:DP:GQ:PL  1/1:0,30:30:89:913,89,0
20  10001436    .   A   AAGGCT  1222.73 .   AC=2;AF=1.00;AN=2;DP=29;ExcessHet=3.0103;FS=0.000;MLEAC=2;MLEAF=1.00;MQ=60.00;QD=25.36;SOR=0.836    GT:AD:DP:GQ:PL  1/1:0,28:28:84:1260,84,0
20  10001474    .   C   T   843.77  .   AC=2;AF=1.00;AN=2;DP=27;ExcessHet=3.0103;FS=0.000;MLEAC=2;MLEAF=1.00;MQ=60.00;QD=31.25;SOR=1.302    GT:AD:DP:GQ:PL  1/1:0,27:27:81:872,81,0
20  10001617    .   C   A   493.77  .   AC=1;AF=0.500;AN=2;BaseQRankSum=1.63;ClippingRankSum=0.00;DP=38;ExcessHet=3.0103;FS=1.323;MLEAC=1;MLEAF=0.500;MQ=60.00;MQRankSum=0.00;QD=12.99;ReadPosRankSum=0.170;SOR=1.179   GT:AD:DP:GQ:PL  0/1:19,19:38:99:522,0,480
</pre>
</div>

<p>After the header lines and the field names, each line represents a single variant, with various properties of that variant represented in the columns. Note that all the lines shown in the example above describe SNPs and indels, but other variation types could be described (see the VCF specification for details). Depending on how the callset was generated, there may only be records for sites where a variant was identified, or there may also be "invariant" records, ie records for sites where no variation was identified.</p>

<p>You will sometimes come across VCFs that have only 8 columns, and contain no FORMAT or sample-specific information. These are called "sites-only" VCFs, and represent variation that has been observed in a population. Generally, information about the population of origin should be included in the header.</p>

<hr>

<h2>3. Interpreting the header information</h2>

<p>The following is a valid VCF header produced by GenotypeGVCFs on an example data set (derived from our favorite test sample, NA12878).  You can download similar test data from our resource bundle and try looking at it yourself.</p>

<div class="table-wrapper" markdown="block">
<pre>##fileformat=VCFv4.2
##ALT=&lt;ID=NON_REF,Description="Represents any possible alternative allele at this location"&gt;
##FILTER=&lt;ID=LowQual,Description="Low quality"&gt;
##FORMAT=&lt;ID=AD,Number=R,Type=Integer,Description="Allelic depths for the ref and alt alleles in the order listed"&gt;
##FORMAT=&lt;ID=DP,Number=1,Type=Integer,Description="Approximate read depth (reads with MQ=255 or with bad mates are filtered)"&gt;
##FORMAT=&lt;ID=GQ,Number=1,Type=Integer,Description="Genotype Quality"&gt;
##FORMAT=&lt;ID=GT,Number=1,Type=String,Description="Genotype"&gt;
##FORMAT=&lt;ID=MIN_DP,Number=1,Type=Integer,Description="Minimum DP observed within the GVCF block"&gt;
##FORMAT=&lt;ID=PGT,Number=1,Type=String,Description="Physical phasing haplotype information, describing how the alternate alleles are phased in relation to one another"&gt;
##FORMAT=&lt;ID=PID,Number=1,Type=String,Description="Physical phasing ID information, where each unique ID within a given sample (but not across samples) connects records within a phasing group"&gt;
##FORMAT=&lt;ID=PL,Number=G,Type=Integer,Description="Normalized, Phred-scaled likelihoods for genotypes as defined in the VCF specification"&gt;
##FORMAT=&lt;ID=RGQ,Number=1,Type=Integer,Description="Unconditional reference genotype confidence, encoded as a phred quality -10*log10 p(genotype call is wrong)"&gt;
##FORMAT=&lt;ID=SB,Number=4,Type=Integer,Description="Per-sample component statistics which comprise the Fisher's Exact Test to detect strand bias."&gt;
##GATKCommandLine.HaplotypeCaller=&lt;ID=HaplotypeCaller,Version=3.7-0-gcfedb67,Date="Fri Jan 20 11:14:15 EST 2017",Epoch=1484928855435,CommandLineOptions="[command-line goes here]"&gt;
##GATKCommandLine=&lt;ID=GenotypeGVCFs,CommandLine="[command-line goes here]",Version=4.beta.6-117-g4588584-SNAPSHOT,Date="December 23, 2017 5:45:56 PM EST"&gt;
##INFO=&lt;ID=AC,Number=A,Type=Integer,Description="Allele count in genotypes, for each ALT allele, in the same order as listed"&gt;
##INFO=&lt;ID=AF,Number=A,Type=Float,Description="Allele Frequency, for each ALT allele, in the same order as listed"&gt;
##INFO=&lt;ID=AN,Number=1,Type=Integer,Description="Total number of alleles in called genotypes"&gt;
##INFO=&lt;ID=BaseQRankSum,Number=1,Type=Float,Description="Z-score from Wilcoxon rank sum test of Alt Vs. Ref base qualities"&gt;
##INFO=&lt;ID=ClippingRankSum,Number=1,Type=Float,Description="Z-score From Wilcoxon rank sum test of Alt vs. Ref number of hard clipped bases"&gt;
##INFO=&lt;ID=DP,Number=1,Type=Integer,Description="Approximate read depth; some reads may have been filtered"&gt;
##INFO=&lt;ID=DS,Number=0,Type=Flag,Description="Were any of the samples downsampled?"&gt;
##INFO=&lt;ID=END,Number=1,Type=Integer,Description="Stop position of the interval"&gt;
##INFO=&lt;ID=ExcessHet,Number=1,Type=Float,Description="Phred-scaled p-value for exact test of excess heterozygosity"&gt;
##INFO=&lt;ID=FS,Number=1,Type=Float,Description="Phred-scaled p-value using Fisher's exact test to detect strand bias"&gt;
##INFO=&lt;ID=HaplotypeScore,Number=1,Type=Float,Description="Consistency of the site with at most two segregating haplotypes"&gt;
##INFO=&lt;ID=InbreedingCoeff,Number=1,Type=Float,Description="Inbreeding coefficient as estimated from the genotype likelihoods per-sample when compared against the Hardy-Weinberg expectation"&gt;
##INFO=&lt;ID=MLEAC,Number=A,Type=Integer,Description="Maximum likelihood expectation (MLE) for the allele counts (not necessarily the same as the AC), for each ALT allele, in the same order as listed"&gt;
##INFO=&lt;ID=MLEAF,Number=A,Type=Float,Description="Maximum likelihood expectation (MLE) for the allele frequency (not necessarily the same as the AF), for each ALT allele, in the same order as listed"&gt;
##INFO=&lt;ID=MQ,Number=1,Type=Float,Description="RMS Mapping Quality"&gt;
##INFO=&lt;ID=MQRankSum,Number=1,Type=Float,Description="Z-score From Wilcoxon rank sum test of Alt vs. Ref read mapping qualities"&gt;
##INFO=&lt;ID=QD,Number=1,Type=Float,Description="Variant Confidence/Quality by Depth"&gt;
##INFO=&lt;ID=RAW_MQ,Number=1,Type=Float,Description="Raw data for RMS Mapping Quality"&gt;
##INFO=&lt;ID=ReadPosRankSum,Number=1,Type=Float,Description="Z-score from Wilcoxon rank sum test of Alt vs. Ref read position bias"&gt;
##INFO=&lt;ID=SOR,Number=1,Type=Float,Description="Symmetric Odds Ratio of 2x2 contingency table to detect strand bias"&gt;
##contig=&lt;ID=20,length=63025520&gt;
##reference=file:///data/ref/ref.fasta
##source=GenotypeGVCFs
</pre>
</div>


<p>This is a lot of lines, so let us break it down into digestible bits. Note that the header lines are always listed in alphabetical order.</p>

<h3>VCF spec version</h3>

<p>The first line:</p>

<pre>##fileformat=VCFv4.2
</pre>

<p>tells you the version of the VCF specification to which the file conforms. This may seem uninteresting but it can have some important consequences for how to handle and interpret the file contents. As genomics is a fast moving field, the file formats are evolving fairly rapidly, so some of the encoding conventions change. If you run into unexpected issues while trying to parse a VCF file, be sure to check the version and the spec for any relevant format changes.</p>

<h3>FILTER lines</h3>

<p>The FILTER lines tell you what filters have been applied to the data. In our test file, one filter has been applied:</p>

<pre>##FILTER=&lt;ID=LowQual,Description="Low quality"&gt;
</pre>

<p>Records that fail any of the filters listed here will contain the ID of the filter (here, <code>LowQual</code>) in its <code>FILTER</code> field (see how records are structured further below).</p>

<h3>FORMAT and INFO lines</h3>

<p>These lines define the annotations contained in the <code>FORMAT</code> and <code>INFO</code> columns of the VCF file, which we explain further below. If you ever need to know what an annotation stands for, you can always check the VCF header for a brief explanation (at least if you are using a civilized program that writes definition lines to the header).</p>

<h3>GATKCommandLine</h3>

<p>The GATKCommandLine lines contain all the parameters that went used by the tool that generated the file. Here, <code>GATKCommandLine.HaplotypeCaller</code> refers to a command line invoking HaplotypeCaller. These parameters include all the arguments that the tool accepts, along with the values that were applied (if you do not pass one, a default is applied); so it is not just the arguments specified explicitly by the user in the command line.</p>

<h3>Contig lines and Reference</h3>

<p>These contain the contig names, lengths, and which reference assembly was used with the input BAM file. This can come in handy when someone gives you a callset but does not tell you which reference it was derived from -- remember that for many organisms, there are multiple reference assemblies, and you should always make sure to use the appropriate one!</p>

<p>For more information on genome references, see the corresponding Dictionary entry.</p>

<hr>

<h2>4. Structure of variant call records</h2>

<p>For each site record, the information is structured into columns (also called fields) as follows:</p>

<div class="table-wrapper" markdown="block">
<pre>#CHROM  POS ID  REF ALT     QUAL    FILTER  INFO    FORMAT  NA12878 [other samples...]
</pre>
</div>

<p>The first 8 columns of the VCF records (up to and including <code>INFO</code>) represent the properties observed at the level of the variant (or invariant) site. Keep in mind that when multiple samples are represented in a VCF file, some of the site-level annotations represent a summary or average of the values obtained for that site from the different samples.</p>

<p>Sample-specific information such as genotype and individual sample-level annotation values are contained in the <code>FORMAT</code> column (9th column) and in the sample-name columns (10th and beyond). In the example above, there is one sample called NA12878; if there were additional samples there would be additional columns to the right. Most programs order the sample columns alphabetically by sample name, but this is not always the case, so be aware that you can not depend on ordering rules for parsing VCF output!</p>

<h3>Site-level properties and annotations</h3>

<p>These first 7 fields are required by the VCF format and must be present, although they can be empty (in practice, there has to be a dot, ie <code>.</code> to serve as a placeholder).</p>

<h4>CHROM and POS</h4>

<p>The contig and genomic coordinates on which the variant occurs. Note that for deletions the position given is actually the base preceding the event.</p>

<h4>ID</h4>

<p>An optional identifier for the variant. Based on the contig and position of the call and whether a record exists at this site in a reference database such as dbSNP. A typical identifier is the dbSNP ID, which in human data would look like rs28548431, for example.</p>

<h4>REF and ALT</h4>

<p>The reference allele and alternative allele(s) observed in a sample, set of samples, or a population in general (depending how the VCF was generated). The REF and ALT alleles are the only required elements of a VCF record that tell us whether the variant is a SNP or an indel (or in complex cases, a mixed-type variant). If we look at the following two sites, we see the first is a SNP, the second is an insertion and the third is a deletion:</p>

<div class="table-wrapper" markdown="block">
<pre>20  10001298    .   T   A   884.77  .   [CLIPPED]   GT:AD:DP:GQ:PL  1/1:0,30:30:89:913,89,0
20  10001436    .   A   AAGGCT  1222.73 .   [CLIPPED]   GT:AD:DP:GQ:PL  1/1:0,28:28:84:1260,84,0
20  10004769    .   TAAAACTATGC T   622.73  .   [CLIPPED]   GT:AD:DP:GQ:PL  0/1:18,17:35:99:660,0,704
</pre>
</div>

<p>Note that REF and ALT are always given on the forward strand. For insertions, the ALT allele includes the inserted sequence as well as the base preceding the insertion so you know where the insertion is compared to the reference sequence. For deletions, the ALT allele is the base before the deletion.</p>

<h4>QUAL</h4>

<p>The <a href="https://en.wikipedia.org/wiki/Phred_quality_score">Phred-scaled</a> probability that a REF/ALT polymorphism exists at this site given sequencing data. Because the Phred scale is -10 * log(1-p), a value of 10 indicates a 1 in 10 chance of error, while a 100 indicates a 1 in 10^10 chance (see the <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035531872-Phred-scaled-quality-scores">Technical Documentation</a>). These values can grow very large when a large amount of data is used for variant calling, so QUAL is not often a very useful property for evaluating the quality of a variant call. See our documentation on filtering variants for more information on this topic.</p>

<p>Not to be confused with the sample-level annotation GQ; see <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035531392">this FAQ article</a> for an explanation of the differences in what they mean and how they should be used.</p>

<h4>FILTER</h4>

<p>This field contains the name(s) of any filter(s) that the variant fails to pass, or the value <code>PASS</code> if the variant passed all filters. If the FILTER value is <code>.</code>, then no filtering has been applied to the records. It is extremely important to apply appropriate filters before using a variant callset in downstream analysis. See our documentation on filtering variants for more information on this topic.</p>

<h4>INFO</h4>

<p>Various site-level annotations. This  field is not required to be present in the VCF.</p>

<p>The annotations contained in the INFO field are represented as tag-value pairs, where the tag and value are separated by an equal sign, ie <code>=</code>, and pairs are separated by colons, ie <code>;</code> as in this example: <code>MQ=99.00;MQ0=0;QD=17.94</code>. They typically summarize context information from the samples, but can also include information from other sources (e.g. population frequencies from a database resource). Some are annotated by default by the GATK tools that produce the callset, and some can be added on request. They are always defined in the VCF header, so that is an easy way to check what an annotation means if you do not recognize it. You can also find additional information on how they are calculated and how they should be interpreted in the <a href="https://gatk.broadinstitute.org/hc/en-us/categories/360002369672">Tool Index</a>.</p>

<h3>Sample-level annotations</h3>

<p>At this point you have met all the fields up to INFO in this lineup:</p>


<div class="table-wrapper" markdown="block">
<pre>#CHROM  POS ID  REF ALT     QUAL    FILTER  INFO    FORMAT  NA12878 [other samples...]
</pre>
</div>

<p>All the rest is going to be sample-level information. Sample-level annotations are tag-value pairs, like the INFO annotations, but the formatting is a bit different. The short names of the sample-level annotations are recorded in the <code>FORMAT</code> field. The annotation values are then recorded in corresponding order in each sample column (where the sample names are the <code>SM</code> tags identified in the read group data). Typically, you will at minimum have information about the genotype and confidence in the genotype for the sample at each site. See the next section on genotypes for more details.</p>

<hr>

<h2>5. Interpreting genotype and other sample-level information</h2>

<p>The sample-level information contained in the VCF (also called "genotype fields") may look a bit complicated at first glance, but they are actually not that hard to interpret once you understand that they are just sets of tags and values.</p>

<p>Let us take a look at three of the records shown earlier, simplified to just show the key genotype annotations:</p>

<div class="table-wrapper" markdown="block">
<pre>20  10001019    .   T   G   364.77  .   [CLIPPED]   GT:AD:DP:GQ:PL  0/1:18,15:33:99:393,0,480
20  10001298    .   T   A   884.77  .   [CLIPPED]   GT:AD:DP:GQ:PL  1/1:0,30:30:89:913,89,0
20  10001436    .   A   AAGGCT  1222.73 .   [CLIPPED]   GT:AD:DP:GQ:PL  1/1:0,28:28:84:1260,84,0
</pre>
</div>

<p>Looking at that last column, here is what the tags mean:</p>

<h3>GT</h3>

<p>The genotype of this sample at this site. For a diploid organism, the GT field indicates the two alleles carried by the sample, encoded by a 0 for the REF allele, 1 for the first ALT allele, 2 for the second ALT allele, etc.  When there is a single ALT allele (by far the more common case), GT will be either:</p>

<div class="table-wrapper" markdown="block">
<pre>- 0/0 : the sample is homozygous reference
- 0/1 : the sample is heterozygous, carrying 1 copy of each of the REF and ALT alleles
- 1/1 : the sample is homozygous alternate
</pre>
</div>

<p>In the three sites shown in the example above, NA12878 is observed with the allele combinations T/G, A/A and AAGGCT/AAGGCT respectively. For non-diploids, the same pattern applies; in the haploid case there will be just a single value in GT (<em>e.g.</em> <code>1</code>); for polyploids there will be more, <em>e.g.</em> 4 values for a tetraploid organism (<em>e.g.</em> <code>0/0/1/1</code>).</p>

<h3>AD and DP</h3>

<p>Allele depth (AD) and depth of coverage (DP). These are complementary fields that represent two important ways of thinking about the depth of the data for this sample at this site.</p>

<p><strong>AD</strong> is the unfiltered allele depth, <em>i.e.</em> the number of reads that support each of the reported alleles. All reads at the position (including reads that did not pass the variant caller’s filters) are included in this number, except reads that were considered uninformative. Reads are considered uninformative when they do not provide enough statistical evidence to support one allele over another.</p>

<p><strong>DP</strong> is the filtered depth, at the sample level. This gives you the number of filtered reads that support each of the reported alleles. You can check the variant caller’s documentation to see which filters are applied by default. Only reads that passed the variant caller’s filters are included in this number. However, unlike the AD calculation, uninformative reads are included in DP.</p>

<p>See the Tool Documentation for more details on <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360036711711-DepthPerAlleleBySample">AD (DepthPerAlleleBySample)</a> and <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360036347832-Coverage">DP (Coverage)</a> for more details.</p>

<h3>PL</h3>

<p>"Normalized" <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035531872">Phred-scaled</a> likelihoods of the possible genotypes. For the typical case of a monomorphic site (where there is only one ALT allele) in a diploid organism, the PL field will contain three numbers, corresponding to the three possible genotypes (0/0, 0/1, and 1/1). The PL values are "normalized" so that the PL of the most likely genotype (assigned in the GT field) is 0 in the Phred scale. We use "normalized" in quotes because these are not probabilities. We set the most likely genotype PL to 0 for easy reading purpose. The other values are scaled relative to this most likely genotype.</p>

<p>Keep in mind, if you are not familiar with the statistical lingo, that when we say PL is the "Phred-scaled likelihood of the genotype", we mean it is "How much less likely that genotype is compared to the best one". Have a look at <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035890451">this article</a> for an example of how PL is calculated.</p>

<h3>GQ</h3>

<p>The Genotype Quality represents the <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035531872">Phred-scaled</a> confidence that the genotype assignment (GT) is correct, derived from the genotype PLs. Specifically, the GQ is the difference between the PL of the second most likely genotype, and the PL of the most likely genotype. As noted above, the values of the PLs are normalized so that the most likely PL is always 0, so the GQ ends up being equal to the second smallest PL, unless that PL is greater than 99. In GATK, the value of GQ is capped at 99 because larger values are not more informative, but they take more space in the file. So if the second most likely PL is greater than 99, we still assign a GQ of 99.</p>

<p>Basically the GQ gives you the difference between the likelihoods of the two most likely genotypes. If it is low, you can tell there is not much confidence in the genotype, i.e. there was not enough evidence to confidently choose one genotype over another. See the <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035531872">FAQ article on the Phred scale</a> to get a sense of what would be considered low.</p>

<p>Not to be confused with the site-level annotation QUAL; see <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035531392">this FAQ article</a> for an explanation of the differences in what they mean and how they should be used.</p>

<h3>A few examples</h3>

<p>With all the definitions out of the way, let us interpret the genotype information for a few records from our NA12878 callset, starting with at position 10001019 on chromosome 20:</p>

<div class="table-wrapper" markdown="block">
<pre>20  10001019    .   T   G   364.77  .   [CLIPPED]   GT:AD:DP:GQ:PL  0/1:18,15:33:99:393,0,480
</pre>
</div>

<p>At this site, the called genotype is <code>GT = 0/1</code>, which corresponds to a heterozygous genotype with alleles T/G. The confidence indicated by <code>GQ = 99</code> is very good; there were a total of 33 informative reads at this site (<code>DP=33</code>), 18 of which supported the REF allele (=had the reference base) and 15 of which supported the ALT allele (=had the alternate base) (indicated by <code>AD=18,15</code>). The degree of certainty in our genotype is evident in the PL field, where <code>PL(0/1) = 0</code> (the normalized value that corresponds to a likelihood of 1.0) as is always the case for the assigned allele; the next PL is  <code>PL(0/0) = 393</code>, corresponding to 10^(-39.3), or 5.0118723e-40 which is a very small number indeed; and the next one will be even smaller. The GQ ends up being 99 because of the capping as explained above.</p>

<p>Now let us look at a site where our confidence is quite a bit lower:</p>

<div class="table-wrapper" markdown="block">
<pre>20  10024300    .   C   CTT 43.52   .   [CLIPPED]   GT:AD:DP:GQ:PL  0/1:1,4:6:20:73,0,20
</pre>
</div>

<p>Here we have an indel -- specifically an insertion of <code>TT</code> after the reference <code>C</code> base at position 10024300.  The called genotype is <code>GT = 0/1</code> again, but this time the <code>GQ = 20</code> indicates that even though this is probably a real variant (the QUAL is not too bad), we are not sure we have the right genotype. Looking at the coverage annotations, we see we only had 6 reads there, of which 1 supported REF and 4 supported ALT (and one read must have been considered uninformative, possibly due to quality issues). With so little coverage, we ca not be sure that the genotype should not in fact be homozygous variant.</p>

<p>Finally, let us look at a more complicated example:</p>

<div class="table-wrapper" markdown="block">
<pre>20  10009875    .   A   G,AGGGAGG   1128.77 .   [CLIPPED]   GT:AD:DP:GQ:PL  1/2:0,11,5:16:99:1157,230,161,487,0,434
</pre>
</div>

<p>This site is a doozy; two credible ALT alleles were observed, but the REF allele was not -- so technically this is a biallelic site in our sample, but will be considered multiallelic because there are more than two alleles notated in the record. It is also a mixed-type record, since one of the ALTs by itself would make it an <code>A</code>-&gt;<code>G</code> SNP, and the other would make it an insertion of <code>GGGAGG</code> after the reference <code>A</code>.  The called genotype is <code>GT = 1/2</code>, which means it is a heterozygous genotype composed of two different ALT alleles. The coverage was not great, and was not all that balanced between the two ALTs (since one was supported by 11 reads and the other by 5) but it was sufficient for the program to have high confidence in its call.</p>

<hr>

<h2>6. Basic operations: validating, subsetting and exporting from a VCF</h2>

<p>These are a few common things you may want to do with your VCFs that do not deserve their own tutorial. Let us know if there are other operations you think we should cover here.</p>

<h3>Validate your VCF</h3>

<p>Validation, or checking that the format of the file is correct, follows the specification, and will therefore not break any well-behave tool you choose to run on it. You can do this very simply with ValidateVariants. Note that ValidateVariants can also be used on GVCFs if you use the <code>--gvcf</code> argument.</p>

<h3>Subset records from your VCF</h3>

<p>Sometimes you want to subset just one or a few samples from a big cohort. Sometimes you want to subset to just a genomic region. Sometimes you want to do both at the same time! Well, the same tool can do both, and more; it is called <em>SelectVariants</em> and has a lot of options for doing this in that way (including operating over <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035531852">intervals</a> in the usual way).</p>

<p>There are many options for setting the selection criteria, depending on what you want to achieve. For example, given a single VCF file, one or more samples can be extracted from the file, based either on a complete sample name, or on a pattern match. Variants can also be selected based on annotated properties, such as depth of coverage or allele frequency. This is done using <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035891011">JEXL expressions</a>. Other VCF files can also be used to modify the selection based on concordance or discordance between different callsets (see --discordance / --concordance arguments in the Tool Doc.</p>

<h4>Important notes about subsetting operations</h4>

<ul>
<li><p>In the output VCF, some annotations such as AN (number of alleles), AC (allele count), AF (allele frequency), and DP (depth of coverage) are recalculated as appropriate to accurately reflect the composition of the subset callset.</p></li>
<li><p>By default, SelectVariants will keep all ALT alleles, even if they are no longer supported by any samples after subsetting. This is the correct behavior, as reducing samples down should not change the character of the site, only the AC in the subpopulation. In some cases this will produce monomorphic records, <em>i.e.</em> where no ALT alleles are supported. The tool accepts flags that exclude unsupported alleles and/or monomorphic records from the output.</p></li>
</ul>

<h3>Extract information from a VCF in a sane, (mostly) straightforward way</h3>

<p>Use <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360036711531-VariantsToTable">VariantsToTable</a>.</p>

<p>No, really, <strong>do not write your own parser</strong> if you can avoid it. This is not a comment on how smart or how competent we think you are -- it is a comment on how annoyingly obtuse and convoluted the VCF format is.</p>

<p>Seriously. The VCF format lends itself really poorly to parsing methods like regular expressions, and we hear sob stories all the time from perfectly competent people whose home-brewed parser broke because it could not handle a more esoteric feature of the format. We know we broke a bunch of people's scripts when we introduced a new representation for spanning deletions in multisample callsets. OK, we ended up replacing it with a better representation a month later that was a lot less disruptive and more in line with the spirit of the specification -- but the point is, that first version was technically legal according to the 4.2 spec, and that sort of thing can happen <em>at any time</em>. So yes, the VCF is a difficult format to work with, and one way to deal with that safely is to not home-brew parsers.</p>

<p>(Why are we sticking with it anyway? Because, as Winston Churchill famously put it, VCF is the worst variant call representation, except for all the others.)</p>

<hr>

<h2>7. Merging VCF files</h2>

<p>There are three main reasons why you might want to combine variants from different files into one, and the tool you use depends on what you are trying to achieve.</p>

<ol>
<li><p>The most common case is when you have been parallelizing your variant calling analyses, e.g. running HaplotypeCaller per-chromosome, producing separate VCF files (or GVCF files) per-chromosome. For that case, you can use the Picard tool MergeVcfs to merge the files. See the relevant Tool Doc page for usage details.</p></li>
<li><p>The second case is when you have been using HaplotypeCaller in <code>-ERC GVCF</code> or <code>-ERC BP_RESOLUTION</code> to call variants on a large cohort, producing many GVCF files. You then need to consolidate them before joint-calling variants with GenotypeGVCFs  (for performance reasons). This can be done with either CombineGVCFs or ImportGenomicsDB tools, both of which are specifically designed to handle GVCFs in this way. See the relevant Tool Doc pages for usage details and the Best Practices workflow documentation to learn more about the logic of this workflow.</p></li>
<li><p>The third case is when you want to compare variant calls that were produced from the same samples but using different methods, for comparison. For example, if you are evaluating variant calls produced by different variant callers, different workflows, or the same but using different parameters. For this case, we recommend taking a different approach; rather than merging the VCF files (which can have all sorts of complicated consequences), you can us the VariantAnnotator tool to <em>annotate</em> one of the VCFs with the other treated as a <em>resource</em>.  See the relevant Tool Doc page for usage details.</p></li>
</ol>

<p>There is actually one more reason why you might want to combine variants from different files into one, but we do not recommend doing it: you have produced variant calls from various samples separately, and want to combine them for analysis. This is how people used to do variant analysis on large numbers of samples, but we do not recommend proceeding this way because that workflow suffers from serious methodological flaws. Instead, you should follow our recommendations as laid out in the <a href="https://gatk.broadinstitute.org/hc/en-us/articles/360035894751">Best Practices</a> documentation.</p>

   