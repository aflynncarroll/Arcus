#!/usr/bin/env bash

METAL_BIN=~/software/METAL/build/bin/metal
SCRIPT_DIR=/mnt/arcus/lab/users/flynncarra/projects/20251205_run_phecode_wide_meta/metal_scripts

for M in ${SCRIPT_DIR}/phe_*.metal; do
    echo "Running METAL on $M"
    $METAL_BIN $M
done
