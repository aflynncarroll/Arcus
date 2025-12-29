#!/usr/bin/env bash

. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate plink2_env

cd /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom

#ls eur_5_chr{2..22}.bed | sed 's/.bed//' > eur_5_mergelist.txt


printf "eur_5_chr2.bed eur_5_chr2.bim eur_5_chr2.fam\n" > eur_5_mergelist_fixed.txt
for i in {2..22}; do
    printf "eur_5_chr${i}.bed eur_5_chr${i}.bim eur_5_chr${i}.fam\n"
done >> eur_5_mergelist_plink.txt


plink \
  --bfile eur_5_chr1 \
  --merge-list eur_5_mergelist_plink.txt \
  --make-bed \
  --out eur_5_total 

#  --threads 8


# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/merge_bfiles.sh 
# lab-tasks submit-script --name merge-bfiles --path /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/merge_bfiles.sh --memory 55 --estimated-time 8

# lab-tasks status scit1011-autism-gwas_merge-bfiles_9821



# awk '{print $2}' eur_5_chr*.bim | sort | uniq -d > exclude_snps.txt



# grep -H "1:949608:G:A" eur_5_chr1.bim

# 1:949608:G:A
# 1:11854476:T:G
# 1:209849002:T:C
# 1:226032229:C:T
# 2:55476591:G:A
# 2:85133216:G:A