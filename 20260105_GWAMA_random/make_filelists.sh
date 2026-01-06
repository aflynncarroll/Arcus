#!/usr/bin/env bash


AFR_DIR=/home/flynncarra/projects/20260105_GWAMA_random/AFR_METAL
EUR_DIR=/home/flynncarra/projects/20260105_GWAMA_random/EUR_METAL
OUT_DIR=/home/flynncarra/projects/20260105_GWAMA_random/GWAMA_filelist

mkdir -p "$OUT_DIR"

for AFR_FILE in "$AFR_DIR"/afr_meta_results_phe_*_1.gwama.txt; do
    # Extract PHENO between phe_ and _1
    BASENAME=$(basename "$AFR_FILE")
    PHENO=${BASENAME#afr_meta_results_phe_}
    PHENO=${PHENO%_1.gwama.txt}

    EUR_FILE="${EUR_DIR}/eur_meta_results_phe_${PHENO}_1.gwama.txt"

    # Only write filelist if BOTH files exist
    if [[ ! -f "$EUR_FILE" ]]; then
        echo "Skipping phecode $PHENO (EUR missing)"
        continue
    fi

    OUT_FILE="${OUT_DIR}/phe_${PHENO}_filelist.txt"

    {
        echo "$AFR_FILE"
        echo "$EUR_FILE"
    } > "$OUT_FILE"
done
