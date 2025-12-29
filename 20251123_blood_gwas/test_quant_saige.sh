#!/usr/bin/env bash

# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate saige_env

# ----------------------------
# Paths
# ----------------------------

WORKDIR=/home/flynncarra/projects/20251123_blood_gwas/
P_FILE=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582
PHENOFILE=/mnt/arcus/lab/users/flynncarra/projects/20250916_quantitative_measurements/rw_blood_phenos.tsv
PHENO_LIST=/mnt/arcus/lab/users/flynncarra/projects/20250916_quantitative_measurements/rw_blood_phenos_list.txt
COVARS="sex,age,age_sqr,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10"
QCOVARS="age,age_sqr,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10"
SAIGE_SOFTWARE=/home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata
SPARSE_GRM=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx
SPARSE_IDS=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt
VCF_FILE=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582.vcf.gz
VCF_INDEX=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582.vcf.gz.csi


cd $WORKDIR

mkdir -p results
mkdir -p step_1_output

# ----------------------------
# Testing values
# ----------------------------
CHR=22
SPLIT_ID=1

# ----------------------------
# Select phenotype for this job
# ----------------------------
phecode=$(sed -n "${SPLIT_ID}p" $PHENO_LIST)
echo "Running phenotype: $phecode"

# ----------------------------
# Step 1: Fit null model for each phenotype
# ----------------------------
STEP1_PREFIX=${WORKDIR}/step_1_output/${phecode}_step1
STEP1_RDA=${STEP1_PREFIX}.rda

# Only run Step 1 if output does not exist
if [ ! -f $STEP1_RDA ]; then
    echo "Running Step 1 for $phecode..."
    Rscript ${SAIGE_SOFTWARE}/step1_fitNULLGLMM.R \
        --useSparseGRMtoFitNULL=TRUE \
        --sparseGRMFile=$SPARSE_GRM \
        --sparseGRMSampleIDFile=$SPARSE_IDS \
        --plinkFile=$P_FILE \
        --phenoFile=$PHENOFILE \
        --phenoCol=$phecode \
        --covarColList=$COVARS \
        --qCovarColList=$QCOVARS \
        --sampleIDColinphenoFile=biosample_id \
        --traitType=quantitative \
        --invNormalize=TRUE \
        --outputPrefix=$STEP1_PREFIX \
        --nThreads=1 \
        --LOCO=FALSE \
        --IsOverwriteVarianceRatioFile=TRUE \
        > ${STEP1_PREFIX}.log 2>&1   # <-- redirect stdout and stderr to log file
else
    echo "Step 1 already exists: $STEP1_RDA, skipping"
fi


# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251123_blood_gwas/test_quant_saige.sh

# lab-tasks submit-script --name saige-1c18651582-blood --path /mnt/arcus/lab/users/flynncarra/projects/20251123_blood_gwas/test_quant_saige.sh  --split 1 --parallel 1 --cpu 4 --memory 55 --ett 10

# lab-tasks status scit1011-autism-gwas_saige-1c18651582-blood_572