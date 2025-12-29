#!/bin/bash

start=$SECONDS

cd /mnt/arcus/lab/project/data/interim/batch2/




vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch2/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz

duration=$(( SECONDS - start ))
echo "Elapsed time: ${duration} seconds" > time_e9229326cc.txt

# chmod +x array_e9229326cc_subset.sh 
# lab-tasks submit-script --name e9229326cc-subset --path /home/flynncarra/projects/20251010_filter_arrays/array_e9229326cc_subset.sh --memory 55 --estimated-time 60

# scit1011-autism-gwas_e9229326cc-subset_4625


bcftools query -l /mnt/arcus/lab/project/data/interim/batch2/EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz > /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/e9229326cc_ids.txt


bcftools query -f '%ID\n' /mnt/arcus/lab/project/data/interim/batch2/EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz > /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/e9229326cc_vars.txt


zgrep -v "^#" /mnt/arcus/lab/project/data/interim/batch2/EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz | head


# og files
bcftools query -f '%ID\n' /mnt/arcus/lab/project/data/interim/batch2/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz > /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/e9229326cc_vars_og.txt
# stopped



grep -Fxf /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt <(bcftools query -l /mnt/arcus/lab/project/data/interim/batch2/SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz) > /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/eur_e9229326cc_ids.txt

bcftools query -l /mnt/arcus/lab/project/data/interim/batch2/EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz > /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/e9229326cc_ids.txt



vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz


vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz



grep -Fxf /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt <(bcftools query -l /mnt/arcus/lab/project/data/interim/batch1_2/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz) > /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/eur_1c18651582_ids.txt

bcftools query -l /mnt/arcus/lab/project/data/interim/batch1_2/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz > /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/1c1865158_ids.txt