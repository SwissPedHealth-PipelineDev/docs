## Release DNA SNV INDEL v2

### Annotation settings
See Esembl VEP for details <http://www.ensembl.org/info/docs/tools/vep/script/index.html>

### Note

Note that we use "pick-allele-gene" to reduce memory for guru.
This chooses one line or block of consequence data per variant allele and gene combination.
If you are searching for specific transcript coordinates they may differ or be missing in the guru output.
For all transcript variants use the larger output from VEP (vcf, tsv).
<http://www.ensembl.org/info/docs/tools/vep/script/vep_options.html#opt_pick_allele_gene>

VEP settings

* --everything
* --cache_version ${VEP_VERSION}
* --vcf
* --canonical
* --hgvs
* --symbol
* --pick_allele_gene
* --plugin dbNSFP,${dbNSFP_grch38},ALL

### Information

* Name: `release_dna_snv_indel_v2` <https://swisspedhealth-pipelinedev.github.io/docs/pages/design_dna_snvindel_v1_release.html>
* Source: `design_dna_snvindel_v2` <https://swisspedhealth-pipelinedev.github.io/docs/pages/design_dna_snvindel_v1.html>

#### QV2 gVCF files

* `source: ${ANNOTATION_DIR}`
* `${RELEASE_DNA_SNV_INDEL_V2}/annotation/chr*_bcftools_gatk_norm_decom_maf.recode_vep_dbnsfp.vcf.gz*`

#### QV2 gVCF logs

* `source: /data/wgs/log/annotation`
* `${RELEASE_DNA_SNV_INDEL_V2}/annotation/log`

#### QV2 gVCF scripts

* `source: 14_annotation_conda.sh`
* `${RELEASE_DNA_SNV_INDEL_V1}/annotation/14_annotation_conda.sh.log`
