#!/bin/bash

start=$SECONDS

cd /mnt/arcus/lab/project/data/interim/batch1/

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz

duration=$(( SECONDS - start ))
echo "Elapsed time: ${duration} seconds" > time_34505c4e9a.txt

# chmod +x array_34505c4e9a_subset.sh 
# lab-tasks submit-script --name 34505c4e9a-subset --path /home/flynncarra/projects/20251010_filter_arrays/array_34505c4e9a_subset.sh --memory 55 --estimated-time 60
# lab-tasks status scit1011-autism-gwas_34505c4e9a-subset_7170
# delete to kill instead of status