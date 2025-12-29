#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env

mkdir /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10
cd /home/flynncarra/projects/20251213_afr_geno

# c("array_3b4102e323", "array_eaa8d6126d", "array_34505c4e9a", "array_1c18651582", "array_e9229326cc")

# 1c18651582

plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582 \
  --keep /home/flynncarra/projects/20251213_afr_pheno/1c18651582_id_sub.txt \
  --maf 0.05 \
  --hwe 1e-10 \
  --chr 1-22 \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_1c18651582


plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_1c18651582 \
  --export vcf bgz \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_1c18651582


tabix -C -p vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_1c18651582.vcf.gz 


# e9229326cc

plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_e9229326cc \
  --keep /home/flynncarra/projects/20251213_afr_pheno/e9229326cc_id_sub.txt \
  --maf 0.05 \
  --hwe 1e-10 \
  --chr 1-22 \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_e9229326cc


plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_e9229326cc \
  --export vcf bgz \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_e9229326cc


tabix -C -p vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_e9229326cc.vcf.gz 

# 3b4102e323

plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323 \
  --keep /home/flynncarra/projects/20251213_afr_pheno/3b4102e323_id_sub.txt \
  --maf 0.05 \
  --hwe 1e-10 \
  --chr 1-22 \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_3b4102e323


plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_3b4102e323 \
  --export vcf bgz \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_3b4102e323


tabix -C -p vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_3b4102e323.vcf.gz 

# eaa8d6126d

plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_eaa8d6126d \
  --keep /home/flynncarra/projects/20251213_afr_pheno/eaa8d6126d_id_sub.txt \
  --maf 0.05 \
  --hwe 1e-10 \
  --chr 1-22 \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_eaa8d6126d


plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_eaa8d6126d \
  --export vcf bgz \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_eaa8d6126d


tabix -C -p vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_eaa8d6126d.vcf.gz 

# 34505c4e9a

plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_34505c4e9a \
  --keep /home/flynncarra/projects/20251213_afr_pheno/34505c4e9a_id_sub.txt \
  --maf 0.05 \
  --hwe 1e-10 \
  --chr 1-22 \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_34505c4e9a


plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_34505c4e9a \
  --export vcf bgz \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_34505c4e9a


tabix -C -p vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_10/AFR_34505c4e9a.vcf.gz 

