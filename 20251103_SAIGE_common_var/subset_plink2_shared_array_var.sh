#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env


plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/eur_5_total \
  --extract /mnt/arcus/lab/users/flynncarra/projects/20251029_variants_by_array/array_common_vars.txt \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared