#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env


cd /home/flynncarra/projects/20251120_single_array_phewas

#bcftools query -l /mnt/arcus/lab/project/data/interim/batch2/EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz > 1c18651582_ids.txt

#bcftools query -f '%CHROM\t%POS\t%ID\n' /mnt/arcus/lab/project/data/interim/batch2/EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz

plink2 \
  --bfile /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/eur_5_total \
  --keep 1c18651582_id_sub.txt \
  --geno 0.02 \
  --make-bed \
  --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582


plink2 --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582 --export vcf bgz --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582

tabix -p vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582.vcf.gz 

tabix -C -p vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582.vcf.gz 


conda activate saige_env

Rscript /home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata/createSparseGRM.R       \
    --plinkFile=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582 \
    --nThreads=4  \
    --outputPrefix=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582     \
    --numRandomMarkerforSparseKin=2000      \
    --relatednessCutoff=0.125

# not used in the end as we are out of space
#gsutil cp gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/EUR_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz /home/flynncarra/projects/20251120_single_array_phewas

#gsutil ls gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array