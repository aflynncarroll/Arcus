#!/bin/bash

cd /mnt/arcus/lab/project/data/interim/batch1_2/

bcftools merge \
  --file-list /home/flynncarra/projects/20251010_filter_arrays/eur_array_list.txt \
  -Oz \
  --threads 8 \
  -o /mnt/arcus/lab/project/data/interim/batch1_2/eur_array_total.vcf.gz

  bcftools index -t /mnt/arcus/lab/project/data/interim/batch1_2/eur_array_total.vcf.gz


  # chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/merge_eur_array.sh 
# lab-tasks submit-script --name merge-eur-array --path /mnt/arcus/lab/users/flynncarra/projects/20251010_filter_arrays/merge_eur_array.sh --memory 55 --estimated-time 8

# lab-tasks status scit1011-autism-gwas_merge-eur-array_3962