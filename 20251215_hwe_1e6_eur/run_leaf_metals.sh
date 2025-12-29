#!/usr/bin/env bash


# test
#SPLIT_ID=1


METAL_BIN=~/software/METAL/build/bin/metal
SCRIPT_DIR=/home/flynncarra/projects/20251215_hwe_1e6_eur/leaf_metal_scripts

# Create a sorted array of all metal script files
mapfile -t METAL_SCRIPTS < <(ls -1 ${SCRIPT_DIR}/phe_*.metal | sort)

N=${#METAL_SCRIPTS[@]}

if (( SPLIT_ID > N )); then
    echo "SPLIT_ID ${SPLIT_ID} exceeds number of scripts (${N}). Exiting."
    exit 0
fi

# Select the script corresponding to this SPLIT_ID
INDEX=$((SPLIT_ID - 1))
SCRIPT_TO_RUN="${METAL_SCRIPTS[$INDEX]}"

echo "Running METAL for SPLIT_ID=${SPLIT_ID}"
echo "→ METAL script: ${SCRIPT_TO_RUN}"

"$METAL_BIN" "$SCRIPT_TO_RUN"

# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/run_leaf_metals.sh

# lab-tasks submit-script --name metal-leaf --path /mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/run_leaf_metals.sh  --split 140 --parallel 5 --cpu 4 --memory 55 --ett 3

# lab-tasks status scit1011-autism-gwas_metal-leaf_9158