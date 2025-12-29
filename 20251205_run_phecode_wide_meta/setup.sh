#!/usr/bin/env bash


ls /mnt/arcus/lab/users/flynncarra/projects/20251203_meta_total_200_phecodes/results/*_allchr.txt | sed 's/.*_phe_//' | sed 's/_allchr.txt//' | sort -u > phecode_list.txt

mkdir results