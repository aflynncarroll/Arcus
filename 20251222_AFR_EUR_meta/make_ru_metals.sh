#!/usr/bin/env bash

# Set working directory
cd /mnt/arcus/lab/users/flynncarra/projects/20251222_AFR_EUR_meta/

PHENO_LIST=ru_phecodes_overlap.txt

# Define root directories for both datasets
ROOT_DIR_A=/mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/metal_results
ROOT_DIR_B=/mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/ru_metal_results

# Define other directories
SCRIPT_DIR=/mnt/arcus/lab/users/flynncarra/projects/20251222_AFR_EUR_meta/metal_scripts
OUTDIR=/mnt/arcus/lab/users/flynncarra/projects/20251222_AFR_EUR_meta/metal_results

# Create directories if they don't exist
mkdir -p "$SCRIPT_DIR"
mkdir -p "$OUTDIR"

# Iterate through phecodes and create METAL scripts
while read PHE; do
    METAL_SCRIPT=${SCRIPT_DIR}/phe_${PHE}.metal

    echo "Creating METAL script for ${PHE}: $METAL_SCRIPT"

    # Create METAL script content
    {
        echo "MARKER MarkerName"
        echo "ALLELE Allele2 Allele1"
        echo "EFFECT Effect"
        echo "STDERR StdErr"
        echo "PVALUE P-value"
        echo ""
        echo "SCHEME STDERR"
        echo ""
        echo "OUTFILE ${OUTDIR}/meta_results/meta_results_phe_${PHE}_ .txt"
        echo ""

        # Add PROCESS commands for both root directories (same phecode in both)
        echo "PROCESS ${ROOT_DIR_A}/meta_results_phe_${PHE}_1.txt"
        echo "PROCESS ${ROOT_DIR_B}/meta_results_phe_${PHE}_1.txt"

        echo ""
        echo "ANALYZE"
        echo "QUIT"
    } > "$METAL_SCRIPT"

done < "$PHENO_LIST"
