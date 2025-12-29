#!/usr/bin/env bash


. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate plink2_env


cd /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/


plink2 --vcf /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total.vcf.gz --chr 1-22 --make-bed --out /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total


# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/array_pfiles.sh

# lab-tasks submit-script --name make-eur-pfiles --path /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/array_pfiles.sh --memory 64 --estimated-time 20

# lab-tasks status scit1011-autism-gwas_make-eur-pfiles_6524