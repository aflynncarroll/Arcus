#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env


mkdir /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/



gcloud storage cp gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

gcloud storage cp gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz.tbi /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

 plink2 --vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz \
       --make-bed \
       --max-alleles 2 \
       --geno 0.02 \
       --impute-sex \
       --split-par hg19 \
       --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_e9229326cc

rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz

rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz.tbi


gcloud storage cp gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

gcloud storage cp gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz.tbi /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

 plink2 --vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz \
       --make-bed \
       --max-alleles 2 \
       --geno 0.02 \
       --impute-sex \
       --split-par hg19 \
       --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582

rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz

rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz.tbi



gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz.tbi /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

 plink2 --vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz \
       --make-bed \
       --max-alleles 2 \
       --geno 0.02 \
       --impute-sex \
       --split-par hg19 \
       --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323

rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz

rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz.tbi


gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/



  plink \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_e9229326cc \
  --hwe 1e-10 \
  --write-snplist \
  --out e9229326cc_hwe_var

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch2/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz \
--keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
--maf 0.05 \
--recode --recode-INFO-all \
--stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz


vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch2/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz


gsutil ls -lh gs://scit1011-autism-gwas-b3-def/req-36-files/

gsutil ls -lh gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/

gcloud storage ls gs://scit1011-autism-gwas-b3-def/lab/afc/total_eur_geno