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

WORKDIR=/mnt/arcus/lab/users/flynncarra/projects/20251124_blood_phewas_multi_array/
P_FILE=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared
PHENOFILE=/mnt/arcus/lab/users/flynncarra/projects/20251124_blood_phewas_updated_covar/rw_blood_phenos.tsv
PHENO_LIST=/mnt/arcus/lab/users/flynncarra/projects/20250916_quantitative_measurements/rw_blood_phenos_list.txt
COVARS="age,age_sqr,sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,array_3b4102e323,array_eaa8d6126d,array_34505c4e9a,array_1c18651582,array_e9229326cc,HDS"
QCOVARS="sex,HDS,array_3b4102e323,array_eaa8d6126d,array_34505c4e9a,array_1c18651582,array_e9229326cc"
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
        --phenoCol=$phecode \
        --covarColList=$COVARS \
        --qCovarColList=$QCOVARS \
        --sampleIDColinphenoFile=biosample_id \
        --traitType=quantitative \
        --invNormalize=TRUE \
        --outputPrefix=$STEP1_PREFIX \
        --nThreads=4 \
        --LOCO=FALSE \
        --IsOverwriteVarianceRatioFile=TRUE
else
    echo "Step 1 already exists: $STEP1_RDA, skipping"
fi


# ----------------------------
# Step 2: Run per chromosome
# ----------------------------

for CHR in {1..22}; do
    OUTFILE=${WORKDIR}/results/${phecode}_chr${CHR}.txt
    echo "Running Step 2 for chromosome $CHR -> $OUTFILE"
# glm for quant traits
    Rscript ${SAIGE_SOFTWARE}/step2_SPAtests.R \
        --vcfFile=$VCF_FILE \
        --vcfFileIndex=$VCF_INDEX \
        --vcfField=GT \
        --chrom=$CHR \
        --minMAF=0.01 \
        --minMAC=20 \
        --LOCO=FALSE \
        --GMMATmodelFile=${STEP1_PREFIX}.rda \
        --SAIGEOutputFile=${OUTFILE} \
        --is_output_moreDetails=TRUE \
        --varianceRatioFile=${STEP1_PREFIX}.varianceRatio.txt

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



# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251124_blood_phewas_multi_array/shared_var_saige_blood.sh

# lab-tasks submit-script --name saige-shared-phe-blood --path /mnt/arcus/lab/users/flynncarra/projects/20251124_blood_phewas_multi_array/shared_var_saige_blood.sh  --split 8 --parallel 5 --cpu 4 --memory 55 --ett 10

# lab-tasks status scit1011-autism-gwas_saige-shared-phe-blood_3737