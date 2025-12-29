#!/bin/bash

start=$SECONDS

cd /mnt/arcus/lab/project/data/interim/batch1/

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz

duration=$(( SECONDS - start ))
echo "Elapsed time: ${duration} seconds" > time_eaa8d6126d.txt

# chmod +x array_eaa8d6126d_subset.sh 
# lab-tasks submit-script --name eaa8d6126d-subset --path /home/flynncarra/projects/20251010_filter_arrays/array_eaa8d6126d_subset.sh --memory 55 --estimated-time 200


# lab-tasks status scit1011-autism-gwas_eaa8d6126d-subset_6955
