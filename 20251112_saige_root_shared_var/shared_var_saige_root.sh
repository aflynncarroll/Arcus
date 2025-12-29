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

WORKDIR=/mnt/arcus/lab/users/flynncarra/projects/20251112_saige_root_shared_var/
P_FILE=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared
PHENOFILE=/mnt/arcus/lab/users/flynncarra/projects/20251103_phewas_v3_phenotypes/array_eur_total_phe_200_top.tsv
PHENO_LIST=/mnt/arcus/lab/users/flynncarra/projects/20251103_phewas_v3_phenotypes/phecodes_200_top.txt
COVARS="age,age_sqr,sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10"
SAIGE_SOFTWARE=/home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata
SPARSE_GRM=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_5_shared_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx
SPARSE_IDS=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_5_shared_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt
VCF_FILE=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared.vcf.gz
VCF_INDEX=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared.vcf.gz.csi


cd $WORKDIR

mkdir -p results
mkdir -p step_1_output

# ----------------------------
# Testing values
# ----------------------------
#CHR=22
#SPLIT_ID=1

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
        --skipVarianceRatioEstimation=FALSE \
        --phenoCol=$phecode \
        --covarColList=$COVARS \
        --sampleIDColinphenoFile=biosample_id \
        --traitType=binary \
        --outputPrefix=$STEP1_PREFIX \
        --nThreads=4 \
        --LOCO=FALSE
else
    echo "Step 1 already exists: $STEP1_RDA, skipping"
fi


# ----------------------------
# Step 2: Run per chromosome
# ----------------------------

for CHR in {1..22}; do
    OUTFILE=${WORKDIR}/results/${phecode}_chr${CHR}.txt
    echo "Running Step 2 for chromosome $CHR -> $OUTFILE"

    Rscript ${SAIGE_SOFTWARE}/step2_SPAtests.R \
        --vcfFile=$VCF_FILE \
        --vcfFileIndex=$VCF_INDEX \
        --vcfField=GT \
        --chrom=$CHR \
        --minMAF=0 \
        --minMAC=20 \
        --LOCO=FALSE \
        --GMMATmodelFile=${STEP1_PREFIX}.rda \
        --SAIGEOutputFile=${OUTFILE}
done

# ----------------------------
# Combine results and clean up
# ----------------------------

outfile="${WORKDIR}/results/${phecode}_allchr.txt"

# Get the header from the first file (chr1)
head -n 1 "${WORKDIR}/results/${phecode}_chr1.txt" > "$outfile"

# Append all the rest (skip header lines)
for chr in {1..22}; do
    tail -n +2 "${WORKDIR}/results/${phecode}_chr${chr}.txt" >> "$outfile"
done

# remove individual chrom files
rm -f ${WORKDIR}/results/${phecode}_chr*.txt
rm -f ${WORKDIR}/results/${phecode}_chr*.index



# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251112_saige_root_shared_var/shared_var_saige_root.sh

# lab-tasks submit-script --name saige-shared-root --path /mnt/arcus/lab/users/flynncarra/projects/20251112_saige_root_shared_var/shared_var_saige_root.sh --split 184 --parallel 5 --cpu 4 --memory 55 --ett 24

# lab-tasks status scit1011-autism-gwas_saige-shared-root_9365

# 150 did not finish