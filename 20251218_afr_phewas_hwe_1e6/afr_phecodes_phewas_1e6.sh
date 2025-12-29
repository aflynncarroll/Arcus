#!/usr/bin/env bash
. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate saige_env

# ----------------------------
# Paths
# ----------------------------
# /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_6/

WORKDIR=/home/flynncarra/projects/20251218_afr_phewas_hwe_1e6/

PHENOFILE=/home/flynncarra/projects/20251213_afr_pheno/array_afr_phe_200_comb.tsv
PHENO_LIST=/home/flynncarra/projects/20251213_afr_pheno/combined_columns.txt

ARRAY_LIST=/mnt/arcus/lab/users/flynncarra/projects/20251120_single_array_phewas/array_list.txt

COVARS="age,age_sqr,sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10"
QCOVARS="sex"
SAIGE_SOFTWARE=/home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata

mkdir -p $WORKDIR/results
mkdir -p $WORKDIR/step_1_output

# ----------------------------
# test variables
# ----------------------------
SPLIT_ID=500
#705 combinations 5*141
#CHR=22

# ----------------------------
# Determine ARRAY + PHENO from SPLIT_ID
# ----------------------------
N_ARRAYS=$(wc -l < $ARRAY_LIST)
N_PHENOS=$(wc -l < $PHENO_LIST)

array_index=$(( (SPLIT_ID - 1) / N_PHENOS + 1 ))
pheno_index=$(( (SPLIT_ID - 1) % N_PHENOS + 1 ))

ARRAY_NAME=$(sed -n "${array_index}p" $ARRAY_LIST)
phecode=$(sed -n "${pheno_index}p" $PHENO_LIST)

echo "SPLIT_ID=$SPLIT_ID → ARRAY=$ARRAY_NAME, PHENO=$phecode"

# ----------------------------
# Build array-specific paths
# ----------------------------
BASE=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas_afr/arrays_afr_maf_5_hwe_6/AFR_${ARRAY_NAME}

P_FILE=${BASE}
SPARSE_GRM=${BASE}_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx
SPARSE_IDS=${SPARSE_GRM}.sampleIDs.txt
VCF_FILE=${BASE}.vcf.gz
VCF_INDEX=${VCF_FILE}.csi

# ----------------------------
# Step 1 Paths
# ----------------------------
STEP1_PREFIX=${WORKDIR}/step_1_output/${ARRAY_NAME}_${phecode}_step1
STEP1_RDA=${STEP1_PREFIX}.rda

# ----------------------------
# Step 1 -- biosample_id changed to IID
# ----------------------------

if [ ! -f $STEP1_RDA ]; then
    echo "Running Step 1 for PHENO=$phecode ARRAY=$ARRAY_NAME"
    Rscript ${SAIGE_SOFTWARE}/step1_fitNULLGLMM.R \
        --useSparseGRMtoFitNULL=FALSE \
        --plinkFile=$P_FILE \
        --phenoFile=$PHENOFILE \
        --skipVarianceRatioEstimation=FALSE \
        --phenoCol=$phecode \
        --covarColList=$COVARS \
        --qCovarColList=$QCOVARS \
        --sampleIDColinphenoFile=IID \
        --traitType=binary \
        --outputPrefix=$STEP1_PREFIX \
        --nThreads=4 \
        --LOCO=FALSE \
        --IsOverwriteVarianceRatioFile=TRUE
else
    echo "Step 1 already exists: $STEP1_RDA, skipping"
fi

# ----------------------------
# Step 2
# ----------------------------
for CHR in {1..22}; do
    OUTFILE=${WORKDIR}/results/${ARRAY_NAME}_${phecode}_chr${CHR}.txt
    echo "Running Step 2 for CHR=$CHR ARRAY=$ARRAY_NAME PHENO=$phecode"

    Rscript ${SAIGE_SOFTWARE}/step2_SPAtests.R \
        --vcfFile=$VCF_FILE \
        --vcfFileIndex=$VCF_INDEX \
        --vcfField=GT \
        --chrom=$CHR \
        --minMAF=0.01 \
        --minMAC=20 \
        --LOCO=FALSE \
        --GMMATmodelFile=${STEP1_PREFIX}.rda \
        --SAIGEOutputFile=$OUTFILE \
        --is_output_moreDetails=TRUE \
        --varianceRatioFile=${STEP1_PREFIX}.varianceRatio.txt
done

# ----------------------------
# Combine chromosomes
# ----------------------------
outfile="${WORKDIR}/results/${ARRAY_NAME}_${phecode}_allchr.txt"

head -n 1 "${WORKDIR}/results/${ARRAY_NAME}_${phecode}_chr1.txt" > "$outfile"

for CHR in {1..22}; do
    tail -n +2 "${WORKDIR}/results/${ARRAY_NAME}_${phecode}_chr${CHR}.txt" >> "$outfile"
done

rm -f ${WORKDIR}/results/${ARRAY_NAME}_${phecode}_chr*.txt
rm -f ${WORKDIR}/results/${ARRAY_NAME}_${phecode}_chr*.index

# chmod +x /home/flynncarra/projects/20251218_afr_phewas_hwe_1e6/afr_phecodes_phewas_1e6.sh

# lab-tasks submit-script --name afr-phewas --path /home/flynncarra/projects/20251218_afr_phewas_hwe_1e6/afr_phecodes_phewas_1e6.sh  --split 705 --parallel 5 --cpu 4 --memory 55 --ett 72

# lab-tasks status scit1011-autism-gwas_afr-phewas_5585

# lab-tasks status scit1011-autism-gwas_afr-phewas_5585 | head -n 20

# ls -lh results/ > saige_output_file_list.txt

# find /mnt/arcus/lab/users/flynncarra/projects/20251203_meta_total_200_phecodes/results -maxdepth 1 -type f -name "*_allchr.txt" | wc -l

# lab-tasks status scit1011-autism-gwas_afr-phewas_5585 > task_status.txt

# find /home/flynncarra/projects/20251213_afr_phewas/results -maxdepth 1 -type f | wc -l
