#!/bin/bash

# Directories
HWE_DIR="/mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/"
PHE_DIR="/mnt/arcus/lab/users/flynncarra/projects/20251214_eur_meta_leaf/results"
OUT_DIR="/mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/saige_leaf_results"

mkdir -p "$OUT_DIR"

# Loop over each _hwe_var.txt file
for hwe_file in "$HWE_DIR"/*_hwe_var.txt; do
    prefix=$(basename "$hwe_file" _hwe_var.txt)  # get the prefix, e.g., 1c18651582

    # Find all phewas files starting with this prefix
    for pheno_file in "$PHE_DIR"/${prefix}_phe_*_allchr.txt; do
        outfile="$OUT_DIR/$(basename "$pheno_file")"

        # Run the awk command to filter and keep header
        awk 'NR==FNR {keep[$1]; next} FNR==1 {print; next} $3 in keep' \
            "$hwe_file" "$pheno_file" > "$outfile"

        echo "Filtered $pheno_file -> $outfile"
    done
done

