#!/usr/bin/env bash

GWAMA_BIN=/mnt/arcus/lab/users/flynncarra/software/GWAMA/GWAMA

FILELIST_DIR=/home/flynncarra/projects/20260105_GWAMA_random/GWAMA_filelist
OUT_DIR=/home/flynncarra/projects/20260105_GWAMA_random/GWAMA_output

mkdir -p "$OUT_DIR"

# Collect GWAMA filelists
mapfile -t GWAMA_FILELISTS < <(ls -1 "${FILELIST_DIR}"/phe_*_filelist.txt | sort)

N=${#GWAMA_FILELISTS[@]}

#Test 
SPLIT_ID=45

# Select job for this array index
INDEX=$((SPLIT_ID - 1))
FILELIST="${GWAMA_FILELISTS[$INDEX]}"

BASENAME=$(basename "$FILELIST")
PHENO=${BASENAME#phe_}
PHENO=${PHENO%_filelist.txt}

OUT_FILE="${OUT_DIR}/ae_results_phe_${PHENO}.gwama"

echo "Running GWAMA for SPLIT_ID=${SPLIT_ID}"
echo "→ Phenotype: ${PHENO}"
echo "→ Filelist: ${FILELIST}"
echo "→ Output:   ${OUT_FILE}"

"$GWAMA_BIN" \
    --filelist "$FILELIST" \
    --name_marker MARKERNAME \
    --name_ea EA \
    --name_nea NEA \
    --name_or OR \
    --name_or_95l OR_95L \
    --name_or_95u OR_95U \
    --random \
    --output "$OUT_FILE"


# chmod +x /home/flynncarra/projects/20260105_GWAMA_random/run_GWAMA_random.sh

# lab-tasks submit-script --name gwama-on-metal --path /home/flynncarra/projects/20260105_GWAMA_random/run_GWAMA_random.sh --split 128 --parallel 5 --cpu 4 --memory 55 --ett 24

# lab-tasks status scit1011-autism-gwas_gwama-on-metal_3727 | head -n 20

#45      Failed  33s