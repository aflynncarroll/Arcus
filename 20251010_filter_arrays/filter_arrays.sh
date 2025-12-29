#!/bin/bash


# batch 1

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz


# batch 2

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch2/ \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_
tabix -p vcf EUR_MAF05_


vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch2/ \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_
tabix -p vcf EUR_MAF05_


# /mnt/arcus/lab/project/data/interim/batch1
#   SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz
#   SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz
#   SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz


# batch 1
gsutil ls gs://scit1011-autism-gwas-b3-def/req-36-files/

gsutil cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz /mnt/arcus/lab/project/data/interim/batch1_2/



gsutil cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz /mnt/arcus/lab/project/data/interim/batch1_2/



gsutil cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz /mnt/arcus/lab/project/data/interim/batch1_2/

gsutil cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz.tbi /mnt/arcus/lab/project/data/interim/batch1/



gsutil ls -lh gs://scit1011-autism-gwas-b3-def/arcus-data/vcf

# batch 2

/mnt/arcus/lab/project/data/interim/batch2/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz

gsutil cp gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz.tbi /mnt/arcus/lab/project/data/interim/batch2/


gsutil cp gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/