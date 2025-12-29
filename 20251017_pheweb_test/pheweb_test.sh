#!/usr/bin/env bash



cd /mnt/arcus/lab/users/flynncarra/projects/20251017_pheweb_test/

conda activate pheweb2_env

conda create -n pheweb2_env python=3.13 -c conda-forge
conda activate pheweb2_env

conda create -n pheweb2_env python=3.12 -c conda-forge
conda activate pheweb2_env
pip install -e .


pheweb2 phenolist import-phenolist /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/t50_file_manifest.csv

pheweb2 process

pheweb2 serve --port 0

curl -X GET "http://localhost:46709/gene/"
# this port worked


pheweb2 serve --gunicorn --enable-cache


cd /mnt/arcus/lab/users/flynncarra/projects/20251017_pheweb_test/

conda activate pheweb_env

pheweb phenolist import-phenolist /mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/t50_file_manifest.csv



/home/flynncarra/.conda/envs/pheweb_env/bin/pheweb