#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env


cd /mnt/arcus/lab/users/flynncarra/projects/20251110_plink2_phewas_shared_var/

# Bed files
bfile_path="/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared"

# phenotype file
phenotype_file="/mnt/arcus/lab/users/flynncarra/projects/20251106_plink2_files/plink2_phenotypes.tsv"

# covariate file
covariate_file="/mnt/arcus/lab/users/flynncarra/projects/20251106_plink2_files/plink2_covariates_3.txt"

# output directory
output_dir="/mnt/arcus/lab/users/flynncarra/projects/20251110_plink2_phewas_shared_var/results"

mkdir -p  "$output_dir"

PHENO_LIST="/mnt/arcus/lab/users/flynncarra/projects/20251106_plink2_files/phecodes_200_v2.txt"

# test
SPLIT_ID=74
#chr=22
# 71, 72, & 74 failed initially but ran when submitted in the interactive session

phecode=$(sed -n "${SPLIT_ID}p" "$PHENO_LIST")
echo "Running phenotype: $phecode"


    plink2 \
        --bfile "${bfile_path}" \
        --logistic \
        --pheno "${phenotype_file}" \
        --pheno-name "${phecode}" \
        --1 \
        --covar "${covariate_file}" \
        --hwe 1e-5 0.001 \
        --maf 0.01 \
        --covar-variance-standardize \
        --out "${output_dir}/eur_${phecode}"



# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251110_plink2_phewas_shared_var/plink2_phewas_shared_var.sh

# lab-tasks submit-script --name plink2-shared-var --path /mnt/arcus/lab/users/flynncarra/projects/20251110_plink2_phewas_shared_var/plink2_phewas_shared_var.sh --split 226 --parallel 5 --cpu 4 --memory 55 --ett 30

# lab-tasks status scit1011-autism-gwas_plink2-shared-var_387




