#!/usr/bin/env bash

# MarkerName      Allele1 Allele2 Effect  StdErr  P-value Direction
# 6:110748999:A:G a       g       0.4173  0.5084  0.4118  ????+

# PROCESS /mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/metal_results/meta_results_phe_315.1_1.txt
# PROCESS /mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/leaf_metal_results/meta_results_phe_315.1_1.txt

cd /home/flynncarra/projects/20260102_test_GWAMA


# adhd 
awk '
BEGIN {
    OFS="\t";
    print "MARKERNAME","EA","NEA","OR","OR_95L","OR_95U"
}
NR>1 {
    beta = $4
    se   = $5
    or   = exp(beta)
    lci  = exp(beta - 1.96*se)
    uci  = exp(beta + 1.96*se)
    print $1, toupper($2), toupper($3), or, lci, uci
}
' /mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/metal_results/meta_results_phe_315.1_1.txt >  /home/flynncarra/projects/20260102_test_GWAMA/GWAMA_input/afr_meta_results_phe_313.1_1.gwama.txt


awk '
BEGIN {
    OFS="\t";
    print "MARKERNAME","EA","NEA","OR","OR_95L","OR_95U"
}
NR>1 {
    beta = $4
    se   = $5
    or   = exp(beta)
    lci  = exp(beta - 1.96*se)
    uci  = exp(beta + 1.96*se)
    print $1, toupper($2), toupper($3), or, lci, uci
}
' /mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/leaf_metal_results/meta_results_phe_315.1_1.txt >  /home/flynncarra/projects/20260102_test_GWAMA/GWAMA_input/eur_meta_results_phe_313.1_1.gwama.txt

# asd

awk '
BEGIN {
    OFS="\t";
    print "MARKERNAME","EA","NEA","OR","OR_95L","OR_95U"
}
NR>1 {
    beta = $4
    se   = $5
    or   = exp(beta)
    lci  = exp(beta - 1.96*se)
    uci  = exp(beta + 1.96*se)
    print $1, toupper($2), toupper($3), or, lci, uci
}
' /mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/metal_results/meta_results_phe_313.3_1.txt >  /home/flynncarra/projects/20260102_test_GWAMA/GWAMA_input/afr_meta_results_phe_313.3_1.gwama.txt



awk '
BEGIN {
    OFS="\t";
    print "MARKERNAME","EA","NEA","OR","OR_95L","OR_95U"
}
NR>1 {
    beta = $4
    se   = $5
    or   = exp(beta)
    lci  = exp(beta - 1.96*se)
    uci  = exp(beta + 1.96*se)
    print $1, toupper($2), toupper($3), or, lci, uci
}
' /mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/leaf_metal_results/meta_results_phe_313.3_1.txt >  /home/flynncarra/projects/20260102_test_GWAMA/GWAMA_input/eur_meta_results_phe_313.3_1.gwama.txt




