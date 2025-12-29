#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env


cd /home/flynncarra/projects/20251126_prep_array_subs


plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/eur_5_total \
  --keep /home/flynncarra/projects/20251120_single_array_phewas/eaa8d6126d_id_sub.txt \
  --geno 0.02 \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_eaa8d6126d


plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_eaa8d6126d \
  --export vcf bgz \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_eaa8d6126d


tabix -C -p vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_eaa8d6126d.vcf.gz 


conda activate saige_env

Rscript /home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata/createSparseGRM.R       \
    --plinkFile=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_eaa8d6126d \
    --nThreads=4  \
    --outputPrefix=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_eaa8d6126d     \
    --numRandomMarkerforSparseKin=2000      \
    --relatednessCutoff=0.125

