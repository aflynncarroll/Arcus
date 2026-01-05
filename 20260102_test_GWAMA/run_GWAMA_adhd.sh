#!/usr/bin/env bash

cd /home/flynncarra/projects/20260102_test_GWAMA

/mnt/arcus/lab/users/flynncarra/software/GWAMA/GWAMA \
--filelist /home/flynncarra/projects/20260102_test_GWAMA/phe_313.1_filelist.txt \
--name_marker MARKERNAME \
--name_ea EA \
--name_nea NEA \
--name_or OR \
--name_or_95l OR_95L \
--name_or_95u OR_95U \
--random \
--output /home/flynncarra/projects/20260102_test_GWAMA/GWAMA_output/ae_results_phe_313.1.gwama

# make filelist for GWAMA
echo "/home/flynncarra/projects/20260102_test_GWAMA/GWAMA_input/eur_meta_results_phe_313.3_1.gwama.txt" > phe_313.3_filelist.txt

# Second file
echo "/home/flynncarra/projects/20260102_test_GWAMA/GWAMA_input/afr_meta_results_phe_313.3_1.gwama.txt" >> phe_313.3_filelist.txt

time /mnt/arcus/lab/users/flynncarra/software/GWAMA/GWAMA \
--filelist /home/flynncarra/projects/20260102_test_GWAMA/phe_313.3_filelist.txt \
--name_marker MARKERNAME \
--name_ea EA \
--name_nea NEA \
--name_or OR \
--name_or_95l OR_95L \
--name_or_95u OR_95U \
--random \
--output /home/flynncarra/projects/20260102_test_GWAMA/GWAMA_output/ae_results_phe_313.3.gwama

# real    7m48.346s