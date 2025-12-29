#!/usr/bin/env bash
. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate saige_env

# ----------------------------
# Paths
# ----------------------------

WORKDIR=/mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array

PHENOFILE=/mnt/arcus/lab/users/flynncarra/projects/20251103_phewas_v3_phenotypes/array_eur_total_phe_200_top.tsv
PHENO_LIST=/mnt/arcus/lab/users/flynncarra/projects/20251103_phewas_v3_phenotypes/phecodes_200_top.txt

ARRAY_LIST=/mnt/arcus/lab/users/flynncarra/projects/20251120_single_array_phewas/array_list.txt

COVARS="age,age_sqr,sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10"
QCOVARS="sex"
SAIGE_SOFTWARE=/home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata

mkdir -p $WORKDIR/results
mkdir -p $WORKDIR/step_1_output

# ----------------------------
# test variables
# ----------------------------
#SPLIT_ID=971
#1130 combinations
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
BASE=/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_${ARRAY_NAME}

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
# Step 1
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
        --sampleIDColinphenoFile=biosample_id \
        --traitType=binary \
        --outputPrefix=$STEP1_PREFIX \
        --nThreads=4 \
        --LOCO=FALSE
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

# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array/ru_phecodes_saige_by_array.sh

# lab-tasks submit-script --name saige-indv-array-phecodes --path /mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array/ru_phecodes_saige_by_array.sh  --split 920 --parallel 5 --cpu 4 --memory 55 --ett 72

# lab-tasks status scit1011-autism-gwas_saige-indv-array-phecodes_5986

# lab-tasks status scit1011-autism-gwas_saige-indv-array-phecodes_5986 | head -n 200

# ls -lh results/ > saige_output_file_list.txt

# find /mnt/arcus/lab/users/flynncarra/projects/20251203_meta_total_200_phecodes/results -maxdepth 1 -type f -name "*_allchr.txt" | wc -l
