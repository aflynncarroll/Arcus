#!/usr/bin/env bash

. ~/.bashrc
eval "$(conda shell.bash hook)";
conda activate saige_env

cd /mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/

CHR=$SPLIT_ID

Rscript /home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata/step2_SPAtests.R \
    --vcfFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz  \
    --vcfFileIndex=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz.csi  \
    --vcfField=GT   \
    --SAIGEOutputFile=/mnt/arcus/lab/project/data/interim/total_eur/HM3_EUR_R_SAIGE_phe_313.3_vcf.txt \
    --chrom=${CHR} \
    --minMAF=0 \
    --minMAC=20 \
    --LOCO=FALSE \
    --GMMATmodelFile=/mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/HM3_EUR_R_SAIGE_step1_GLMM_binary_sparseGRM_vr.rda \
    --SAIGEOutputFile=/mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/eur_phe_313.3_chr${CHR}.txt 


# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/saige_split_asd.sh

# lab-tasks submit-script --name saige-asd --path /mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/saige_split_asd.sh --split 22 --parallel 5 --cpu 4 --memory 32 --ett 8

# scit1011-autism-gwas_saige-asd_4599
