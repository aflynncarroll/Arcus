#!/usr/bin/env bash



gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/



gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/


gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/


gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251010_google_bucket/upload_eur_array.sh

# lab-tasks submit-script --name upload-array-data --path /mnt/arcus/lab/users/flynncarra/projects/20251010_google_bucket/upload_eur_array.sh --memory 55 --estimated-time 6

# lab-tasks status scit1011-autism-gwas_upload-array-data_520


gcloud storage mv /mnt/arcus/lab/project/data/interim/batch1_2/ gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gcloud storage mv /mnt/arcus/lab/project/data/interim/total_eur/eur_array_total.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/
gcloud storage mv /mnt/arcus/lab/project/data/interim/total_eur/eur_array_total.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gcloud storage ls gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/