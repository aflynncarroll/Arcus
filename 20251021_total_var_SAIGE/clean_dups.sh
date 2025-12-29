#!/usr/bin/env bash

. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate plink2_env

cd /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom


for i in {1..22}; do
    plink --bfile eur_5_chr${i} \
          --exclude exclude_snps.txt \
          --make-bed \
          --out eur_5_chr${i}
done
