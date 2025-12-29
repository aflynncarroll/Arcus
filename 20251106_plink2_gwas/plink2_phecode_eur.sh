#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env


cd /home/flynncarra/projects/20251106_plink2_gwas

# PGEN files
bfile_path="/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total"

# phenotype file
phenotype_file="/mnt/arcus/lab/users/flynncarra/projects/20251106_plink2_files/plink2_phenotypes.tsv"

# covariate file
covariate_file="/mnt/arcus/lab/users/flynncarra/projects/20251106_plink2_files/plink2_covariates_2.txt"

# output directory
output_dir="/home/flynncarra/projects/20251106_plink2_gwas/output_files"

mkdir -p  "$output_dir"

PHENO_LIST="/mnt/arcus/lab/users/flynncarra/projects/20251106_plink2_files/phecodes_200_v2.txt"

# test
#SPLIT_ID=1   
#chr=22

phecode=$(sed -n "${SPLIT_ID}p" $PHENO_LIST)
echo "Running phenotype: $phecode"


# Loop through chromosomes 1 to 22
for chr in {1..22}
do
    
    plink2 \
        --bfile "${bfile_path}" \
        --logistic \
        --chr "${chr}" \
        --pheno "${phenotype_file}" \
        --pheno-name "${phecode}" \
        --1 \
        --covar "${covariate_file}" \
        --hwe 1e-5 0.001 \
        --maf 0.01 \
        --covar-variance-standardize \
        --out "${output_dir}/eur_${phecode}_gwas_chr${chr}"
done

#--hwe 1e-12 \

# Append all the rest (skip header lines)
for chr in {1..22}; do
    tail -n +2 "${output_dir}/eur_${phecode}_gwas_chr${chr}.${phecode}.glm.logistic.hybrid" >> "${output_dir}/eur_${phecode}_gwas_allchr.txt"
    tail -n +2 "${output_dir}/eur_${phecode}_gwas_chr${chr}.log" >> "${output_dir}/eur_${phecode}_gwas_allchr_log.txt"
done

# remove individual chrom files
rm -f ${output_dir}/eur_${phecode}_gwas_chr*.${phecode}.glm.logistic.hybrid
rm -f ${output_dir}/eur_${phecode}_gwas_chr*.log

# chmod +x /home/flynncarra/projects/20251106_plink2_gwas/plink2_phecode_eur.sh

# lab-tasks submit-script --name plink2-hm3-var --path /home/flynncarra/projects/20251106_plink2_gwas/plink2_phecode_eur.sh --split 226 --parallel 5 --cpu 4 --memory 55 --ett 30

# lab-tasks status scit1011-autism-gwas_saige-total-var_134
