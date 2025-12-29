#!/bin/bash

start=$SECONDS

cd /mnt/arcus/lab/project/data/interim/batch1/

vcftools --gzvcf /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz \
  --keep /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
  --maf 0.05 \
  --recode --recode-INFO-all \
  --stdout | bgzip > EUR_MAF05_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz
tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz




# bcftools view \
#     -S /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \        # Keep only samples listed in this file
#     -i 'MAF>=0.05' \                                                                            # Include only variants with MAF >= 0.05
#     -Oz \                                                                                       # Output compressed VCF (.vcf.gz)
#     -o EUR_MAF05_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz \                                       # Output file name
#     /mnt/arcus/lab/project/data/interim/batch1/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz           # <-- This is the input VCF file

# tabix -p vcf EUR_MAF05_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz

duration=$(( SECONDS - start ))
echo "Elapsed time: ${duration} seconds" > time_3b4102e323.txt

# chmod +x array_3b4102e323_subset.sh 
# lab-tasks submit-script --name 3b4102e323-subset --path /home/flynncarra/projects/20251010_filter_arrays/array_3b4102e323_subset.sh --memory 55 --estimated-time 200
# lab-tasks status scit1011-autism-gwas_3b4102e323-subset_3124
# delete to kill instead of status