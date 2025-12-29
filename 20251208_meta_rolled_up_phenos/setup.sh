#!/usr/bin/env bash

cd /mnt/arcus/lab/users/flynncarra/projects/20251208_meta_rolled_up_phenos

ls /mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array/results/*_allchr.txt | sed 's/.*_phe_//' | sed 's/_allchr.txt//' | sort -u > phecode_list.txt

#mkdir results