
#!/usr/bin/env bash

cd /mnt/arcus/lab/users/flynncarra/projects/20251222_AFR_EUR_meta

mkdir metal_results/meta_results

grep -Fx -f /mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/phecode_list.txt \
 /mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/leaf_list.txt \
 | sort -u > phecodes_overlap.txt


 grep -Fx -f /mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/phecode_list.txt \
 /mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/ru_list.txt \
 | sort -u > ru_phecodes_overlap.txt


