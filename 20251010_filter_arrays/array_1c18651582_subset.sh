#!/bin/bash

start=$SECONDS

cd /mnt/arcus/lab/project/data/interim/batch2/

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch2/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz

duration=$(( SECONDS - start ))
echo "Elapsed time: ${duration} seconds" > time_1c18651582.txt

# chmod +x array_1c18651582_subset.sh 
# lab-tasks submit-script --name 1c18651582-subset --path /home/flynncarra/projects/20251010_filter_arrays/array_1c18651582_subset.sh --memory 55 --estimated-time 60

#scit1011-autism-gwas_1c18651582-subset_9787



