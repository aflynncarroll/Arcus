#!/usr/bin/env bash

PHENO_LIST=phecode_list.txt

RESULTS=/mnt/arcus/lab/users/flynncarra/projects/20251203_meta_total_200_phecodes/results
SCRIPT_DIR=/mnt/arcus/lab/users/flynncarra/projects/20251205_run_phecode_wide_meta/metal_scripts
OUTDIR=/mnt/arcus/lab/users/flynncarra/projects/20251205_run_phecode_wide_meta/metal_results

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
