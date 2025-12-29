#!/usr/bin/env bash

# # Batch 2
 for file in SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz \
    # SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz.tbi \
    # SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz \
    # SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz.tbi; 
 do
     if [[ ! -f $file ]]; then
         gsutil cp gs://scit1011-autism-gwas-b3-def/arcus-data/vcf/$file ./
     fi
 done

# Batch 1
#for file in SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz \
#    SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz.tbi \
#    SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz \
#    SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz.tbi \
#    SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz \
#    SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz.tbi; do
#    if [[ ! -f $file ]]; then
#        gsutil cp gs://scit1011-autism-gwas-b3-def/req-36-files/$file ./
#    fi
#done
