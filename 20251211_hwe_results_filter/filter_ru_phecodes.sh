#!/bin/bash

# Directories
HWE_DIR="/home/flynncarra/projects/20251211_hwe_results_filter"
PHE_DIR="/mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array/results"
OUT_DIR="/home/flynncarra/projects/20251211_hwe_results_filter/saige_ru_results"

mkdir -p "$OUT_DIR"

# Loop over each _hwe_var.txt file
for hwe_file in "$HWE_DIR"/*_hwe_var.txt; do
    prefix=$(basename "$hwe_file" _hwe_var.txt)  # get the prefix, e.g., 1c18651582

    # Find all phenotype files starting with this prefix
    for pheno_file in "$PHE_DIR"/${prefix}_phe_*_allchr.txt; do
        outfile="$OUT_DIR/$(basename "$pheno_file")"

        # Run the awk command to filter and keep header
        awk 'NR==FNR {keep[$1]; next} FNR==1 {print; next} $3 in keep' \
            "$hwe_file" "$pheno_file" > "$outfile"

        echo "Filtered $pheno_file -> $outfile"
    done
done


for hwe_file in "$HWE_DIR"/*_hwe_var.txt; do
prefix=$(basename "$hwe_file" _hwe_var.txt)
echo $prefix
done

wc -l /mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array/results/1c18651582_phe_578_allchr.txt
# 506359
wc -l /home/flynncarra/projects/20251211_hwe_results_filter/saige_ru_results/1c18651582_phe_578_allchr.txt
# 505429 = 930

wc -l /mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array/results/34505c4e9a_phe_578_allchr.txt
# 603641
wc -l /home/flynncarra/projects/20251211_hwe_results_filter/saige_ru_results/34505c4e9a_phe_578_allchr.txt
# 603135 = 506