 #!/usr/bin/env bash

cd /home/flynncarra/projects/20251029_variants_by_array
 
export GCS_OAUTH_TOKEN=$(gcloud auth print-access-token)

 
 


bcftools query -l gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz > indv_34505c4e9a.txt

bcftools query -l gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz > indv_3b4102e323.txt

bcftools query -l gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz > indv_e9229326cc.txt

bcftools query -l gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/batch1_2/EUR_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz > indv_eaa8d6126d.txt

bcftools query -l gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/EUR_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz > indv_1c18651582.txt
