#!/usr/bin/env bash

#ls /home/flynncarra/projects/20251215_hwe_1e6_eur/saige_leaf_results/*_allchr.txt | sed 's/.*_phe_//' | sed 's/_allchr.txt//' | sort -u > leaf_list.txt

cd /home/flynncarra/projects/20251215_hwe_1e6_eur/

PHENO_LIST=leaf_list.txt

RESULTS=/home/flynncarra/projects/20251215_hwe_1e6_eur/saige_leaf_results
SCRIPT_DIR=/home/flynncarra/projects/20251215_hwe_1e6_eur/leaf_metal_scripts
OUTDIR=/home/flynncarra/projects/20251215_hwe_1e6_eur/leaf_metal_results

mkdir -p "$SCRIPT_DIR"
mkdir -p "$OUTDIR"

ARRAYS=(
    1c18651582
    3b4102e323
    eaa8d6126d
    34505c4e9a
    e9229326cc
)

while read PHE; do
    METAL_SCRIPT=${SCRIPT_DIR}/phe_${PHE}.metal

    echo "Creating METAL script for ${PHE}: $METAL_SCRIPT"

    {
        echo "MARKER MarkerID"
        echo "ALLELE Allele2 Allele1"
        echo "EFFECT BETA"
        echo "STDERR SE"
        echo "PVALUE p.value"
        echo ""
        echo "SCHEME STDERR"
        echo ""
        echo "OUTFILE ${OUTDIR}/meta_results_phe_${PHE}_ .txt"
        echo ""

        for A in "${ARRAYS[@]}"; do
            echo "PROCESS ${RESULTS}/${A}_phe_${PHE}_allchr.txt"
        done

        echo ""
        echo "ANALYZE"
        echo "QUIT"
    } > "$METAL_SCRIPT"

done < "$PHENO_LIST"
