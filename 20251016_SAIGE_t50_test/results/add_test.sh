#!/bin/bash

DIR="/mnt/arcus/lab/users/flynncarra/projects/20251016_SAIGE_t50_test/results/"

for f in "$DIR"*.txt; do
  awk 'NR==1{print $0 "\ttest"; next} {print $0 "\tADD"}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done
