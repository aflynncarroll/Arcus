#!/bin/bash

start=$SECONDS

cd /mnt/arcus/lab/project/data/interim/batch1/

# Array of files defined inside the script
file_list=("SCIT1011-AUTISM-GWAS_3b4102e323" "SCIT1011-AUTISM-GWAS_eaa8d6126d")

# Arrays in Bash are zero-indexed, but SLURM_ARRAY_TASK_ID starts at 1
INDEX=$((${SPLIT_ID}-1))

# Pick the file corresponding to this job
FILE="${file_list[$INDEX]}"

bcftools view \
    -S /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/eur_ids.txt \
    -i 'MAF>=0.05' \
    -Oz \
    -o EUR_MAF05_${FILE}.vcf.gz \
    /mnt/arcus/lab/project/data/interim/batch1/${FILE}.vcf.gz
tabix -p vcf EUR_MAF05_${FILE}.vcf.gz

duration=$(( SECONDS - start ))
echo "Elapsed time: ${duration} seconds" > time_3b4102e323.txt












