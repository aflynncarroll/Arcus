#!/usr/bin/env bash

. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate plink2_env


# Input/Output setup
VCF=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total.vcf.gz
OUTDIR=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom
CHR=${SPLIT_ID}


# --- 1️⃣ Split by chromosome ---
echo "Processing chromosome ${CHR}"
bcftools view -r ${CHR} ${VCF} -Oz -o ${OUTDIR}/eur_5_chr${CHR}.vcf.gz
bcftools index -t ${OUTDIR}/eur_5_chr${CHR}.vcf.gz

# --- 2️⃣ Convert to PLINK format ---
plink2 \
  --vcf ${OUTDIR}/eur_5_chr${CHR}.vcf.gz \
  --make-bed \
  --out ${OUTDIR}/eur_5_chr${CHR}

echo "✅ Done: chr${CHR}"


# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/split_total_eur_vcf.sh

# lab-tasks submit-script --name saige-asd --path /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/split_total_eur_vcf.sh --split 22 --parallel 5 --cpu 4 --memory 55 --ett 20

# lab-tasks status scit1011-autism-gwas_saige-asd_8612