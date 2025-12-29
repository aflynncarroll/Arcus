#!/bin/bash

# lab-tasks submit-script --name filter-vcfs-eur --path /mnt/arcus/lab/users/flynncarra/projects/20251013_filter_eur_arrays/filter_vcfs_eur.sh --split 5 --parallel 5 --cpu 4 --memory 32 --ett 8
. ~/.bashrc

cd /mnt/arcus/lab/project/data/interim/batch1_2/

filenames=("SCIT1011-AUTISM-GWAS_34505c4e9a" \
           "SCIT1011-AUTISM-GWAS_3b4102e323" \
           "SCIT1011-AUTISM-GWAS_eaa8d6126d" \
           "SCIT1011-AUTISM-GWAS_1c18651582" \
           "SCIT1011-AUTISM-GWAS_e9229326cc")
filename=${filenames[SPLIT_ID - 1]}

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1_2/${filename}.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_${filename}.vcf.gz
tabix -p vcf EUR_${filename}.vcf.gz


# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251013_filter_eur_arrays/filter_vcfs_eur.sh

# lab-tasks status scit1011-autism-gwas_filter-vcfs-eur_2399