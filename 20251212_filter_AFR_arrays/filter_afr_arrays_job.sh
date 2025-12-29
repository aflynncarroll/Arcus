#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"

conda activate plink2_env


ID=4

cd /home/flynncarra/projects/20251212_filter_AFR_arrays/

if (( ID == 1 )); then
    plink2 --vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz \
        --make-bed \
        --max-alleles 2 \
        --geno 0.02 \
        --impute-sex \
        --split-par hg19 \
        --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582

    rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz

    rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz.tbi

elif (( ID == 2 )); then

    # gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

    # gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz.tbi /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

    plink2 --vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz \
        --make-bed \
        --max-alleles 2 \
        --geno 0.02 \
        --impute-sex \
        --split-par hg19 \
        --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323

    rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz

    rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz.tbi

elif (( ID == 3 )); then

    # gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

    # gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz.tbi /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

    plink2 --vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz \
        --make-bed \
        --max-alleles 2 \
        --geno 0.02 \
        --impute-sex \
        --split-par hg19 \
        --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_34505c4e9a

    rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz

    rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz.tbi


elif (( ID == 4 )); then

    # gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

    # gcloud storage cp gs://scit1011-autism-gwas-b3-def/req-36-files/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz.tbi /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/

    plink2 --vcf /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz \
        --make-bed \
        --max-alleles 2 \
        --geno 0.02 \
        --impute-sex \
        --split-par hg19 \
        --out /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_eaa8d6126d

    rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz

    rm /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz.tbi

fi


# chmod +x /home/flynncarra/projects/20251212_filter_AFR_arrays/filter_afr_arrays_job.sh

# lab-tasks submit-script --name afr-geno-files --path /home/flynncarra/projects/20251212_filter_AFR_arrays/filter_afr_arrays_job.sh  --split 1 --parallel 1 --cpu 4 --memory 60 --ett 1

# lab-tasks status scit1011-autism-gwas_afr-geno-files_3607