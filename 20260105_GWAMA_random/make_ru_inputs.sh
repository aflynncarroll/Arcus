#!/usr/bin/env bash

cd /home/flynncarra/projects/20260105_GWAMA_random

PHENO_LIST=/mnt/arcus/lab/users/flynncarra/projects/20251222_AFR_EUR_meta/ru_phecodes_overlap.txt

ROOT_DIR_AFR=/mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/metal_results
ROOT_DIR_EUR=/mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/ru_metal_results

AFR_DIR=/home/flynncarra/projects/20260105_GWAMA_random/AFR_METAL
EUR_DIR=/home/flynncarra/projects/20260105_GWAMA_random/EUR_METAL

mkdir -p "$AFR_DIR" "$EUR_DIR"

# Loop over phenotypes
while read -r PHENO; do
    [[ -z "$PHENO" ]] && continue  # skip empty lines

    AFR_IN="${ROOT_DIR_AFR}/meta_results_phe_${PHENO}_1.txt"
    EUR_IN="${ROOT_DIR_EUR}/meta_results_phe_${PHENO}_1.txt"

    AFR_OUT="${AFR_DIR}/afr_meta_results_phe_${PHENO}_1.gwama.txt"
    EUR_OUT="${EUR_DIR}/eur_meta_results_phe_${PHENO}_1.gwama.txt"

    # Skip if either file does not exist
    if [[ ! -f "$AFR_IN" || ! -f "$EUR_IN" ]]; then
        echo "Skipping phecode $PHENO: missing input file(s)"
        continue
    fi

    echo "Processing phecode $PHENO"

    # AFR
    awk '
    BEGIN {
        OFS="\t";
        print "MARKERNAME","EA","NEA","OR","OR_95L","OR_95U"
    }
    NR>1 {
        beta = $4
        se   = $5
        or   = exp(beta)
        lci  = exp(beta - 1.96*se)
        uci  = exp(beta + 1.96*se)
        print $1, toupper($2), toupper($3), or, lci, uci
    }' "$AFR_IN" > "$AFR_OUT"

    # EUR
    awk '
    BEGIN {
        OFS="\t";
        print "MARKERNAME","EA","NEA","OR","OR_95L","OR_95U"
    }
    NR>1 {
        beta = $4
        se   = $5
        or   = exp(beta)
        lci  = exp(beta - 1.96*se)
        uci  = exp(beta + 1.96*se)
        print $1, toupper($2), toupper($3), or, lci, uci
    }' "$EUR_IN" > "$EUR_OUT"

done < "$PHENO_LIST"


# Skipping phecode 772: missing input file(s)
# Skipping phecode 783: missing input file(s)
# Skipping phecode 785: missing input file(s)
# Skipping phecode 789: missing input file(s)
# Skipping phecode 79: missing input file(s)
# Skipping phecode 790: missing input file(s)
# Skipping phecode 8: missing input file(s)
# Skipping phecode 930: missing input file(s)
# Skipping phecode 939: missing input file(s)
# Skipping phecode 949: missing input file(s)