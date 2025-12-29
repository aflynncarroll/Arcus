#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env

cd /mnt/arcus/lab/users/flynncarra/projects/20251111_find_related/

plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared \
  --make-king square0 \
  --maf 0.1 \
  --out /mnt/arcus/lab/users/flynncarra/projects/20251111_find_related/eur_0.05_shared


plink2 \
    --bfile /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared \
    --king-cutoff 0.0884 \
    --out /mnt/arcus/lab/users/flynncarra/projects/20251111_find_related/plink_king_cut/eur_0.05_shared

