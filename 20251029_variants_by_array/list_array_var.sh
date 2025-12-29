export GCS_OAUTH_TOKEN=$(gcloud auth print-access-token)


bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\n' gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz > 34505c4e9a_var_list.txt


bcftools index gs://your-bucket-name/your-file.vcf.gz

bcftools view -H -x gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz | wc -l

bcftools view -H -x gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/file.vcf.gz | wc -l

gsutil ls -lh gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2

bcftools view gs://genomics-public-data/resources/broad/hg38/v0/1000G.phase3.integrated.sites_only.no_MATCHED_REV.hg38.vcf




gcloud storage cp gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz /home/flynncarra/projects/20251029_variants_by_array/

bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\n' EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz > 34505c4e9a_var_list.txt


gcloud storage cp gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz /home/flynncarra/projects/20251029_variants_by_array/

bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\n' EUR_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz > 3b4102e323_var_list.txt


gcloud storage cp gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz /home/flynncarra/projects/20251029_variants_by_array/

bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\n' EUR_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz > e9229326cc_var_list.txt



gcloud storage cp gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz /home/flynncarra/projects/20251029_variants_by_array/

bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\n' EUR_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz > eaa8d6126d_var_list.txt


gcloud storage cp gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/EUR_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz /home/flynncarra/projects/20251029_variants_by_array/

bcftools query -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\n' EUR_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz > 1c18651582_var_list.txt