#!/bin/bash

cd /mnt/arcus/lab/project/data/interim/total_eur/

bcftools view \
  -S /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_no_dup.txt \
  -i 'MAF>=0.05' \
  -Oz \
  -o /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz \
    /mnt/arcus/lab/project/data/interim/total_eur/hm3_total.vcf.gz

  bcftools index -t /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz


# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251013_filter_eur_arrays/filter_total_eur.sh

# lab-tasks submit-script --name upload-array-data --path /mnt/arcus/lab/users/flynncarra/projects/20251013_filter_eur_arrays/filter_total_eur.sh --memory 55 --estimated-time 20

# lab-tasks status 


plink --noweb --bfile /mnt/arcus/lab/project/data/interim/total_eur/merged_a1.a2.a3.a4.a5 --recode vcf bgz --out /mnt/arcus/lab/project/data/interim/total_eur/hm3_total

conda create -n plink2_env -c bioconda -c conda-forge plink2
conda activate plink2_env

plink2 --bfile /mnt/arcus/lab/project/data/interim/total_eur/merged_a1.a2.a3.a4.a5 \
       --recode vcf bgz \
       --out /mnt/arcus/lab/project/data/interim/total_eur/hm3_total


conda install -c bioconda -c conda-forge saige



plink2 \
  --vcf /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total


