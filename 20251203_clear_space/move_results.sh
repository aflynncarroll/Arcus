#!/usr/bin/env bash


gcloud storage mv /mnt/arcus/lab/project/data/interim/total_eur  gs://scit1011-autism-gwas-b3-def/lab/afc/total_eur_geno

gcloud storage ls -lh gs://scit1011-autism-gwas-b3-def/lab/afc/total_eur_geno