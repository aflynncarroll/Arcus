#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate saige_env

cd /mnt/arcus/lab/users/flynncarra/projects/20251111_find_related/

king -b \
    /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared.bed \
    --unrelated \
    --degree 2 \
    --prefix /mnt/arcus/lab/users/flynncarra/projects/20251111_find_related/eur_0.05_shared_unre

#A list of 11423 unrelated individuals saved in file /mnt/arcus/lab/users/flynncarra/projects/20251111_find_related/eur_0.05_shared_unreunrelated.txt
#An alternative list of 1307 to-be-removed individuals saved in file /mnt/arcus/lab/users/flynncarra/projects/20251111_find_related/eur_0.05_shared_unreunrelated_toberemoved.txt

king -b \
    /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared.bed \
    --unrelated \
    --degree 3 \
    --prefix /mnt/arcus/lab/users/flynncarra/projects/20251111_find_related/eur_0.05_shared_unre_3_
