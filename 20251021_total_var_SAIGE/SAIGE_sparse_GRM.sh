#!/usr/bin/env bash

conda activate plink2_env

plink2 --vcf /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total.vcf.gz --chr 1-22 --make-bed --out /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total


/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total.vcf.gz
# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate saige_env



 Rscript /home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata/createSparseGRM.R       \
     --plinkFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/eur_5_total \
     --nThreads=4  \
     --outputPrefix=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/eur_5_total_sparseGRM       \
     --numRandomMarkerforSparseKin=2000      \
     --relatednessCutoff=0.125