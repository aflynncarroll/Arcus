#!/bin/bash

cd /mnt/arcus/lab/project/data/interim/total_eur/


bcftools view \
  -S /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_no_dup.txt \
  -i 'MAF>=0.05' \
  -Oz \
  -o /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total.vcf.gz \
    /mnt/arcus/lab/project/data/interim/total_eur/eur_array_total.vcf.gz

  bcftools index -t /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total.vcf.gz


# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251013_filter_eur_arrays/filter_total_eur.sh

# lab-tasks submit-script --name upload-array-data --path /mnt/arcus/lab/users/flynncarra/projects/20251013_filter_eur_arrays/filter_total_eur.sh --memory 55 --estimated-time 20

# lab-tasks status scit1011-autism-gwas_upload-array-data_3085