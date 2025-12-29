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

WORKDIR=/mnt/arcus/lab/users/flynncarra/projects/20251103_saige_hm3_comb
P_FILE=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total
PHENOFILE=/mnt/arcus/lab/users/flynncarra/projects/20251103_phewas_v3_phenotypes/array_eur_total_phe_200_comb.tsv
PHENO_LIST=/mnt/arcus/lab/users/flynncarra/projects/20251103_phewas_v3_phenotypes/pheno_list_total_200.txt
COVARS="age,age_sqr,sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10,array_3b4102e323,array_eaa8d6126d,array_34505c4e9a,array_1c18651582,array_e9229326cc"
SAIGE_SOFTWARE=/home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata

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
# Step 1: Fit null model for this phenotype
# ----------------------------
STEP1_PREFIX=${WORKDIR}/step_1_output/${phecode}_step1
STEP1_RDA=${STEP1_PREFIX}.rda

# Only run Step 1 if output does not exist
if [ ! -f $STEP1_RDA ]; then
    echo "Running Step 1 for $phecode..."
    Rscript ${SAIGE_SOFTWARE}/step1_fitNULLGLMM.R \
        --useSparseGRMtoFitNULL=TRUE \
        --sparseGRMFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/eur_5_total_sparseGRM_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx \
        --sparseGRMSampleIDFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/eur_5_total_sparseGRM_relatednessCutoff_0.125_2000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
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
        --vcfFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz \
        --vcfFileIndex=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz.csi \
        --vcfField=GT \
        --chrom=$CHR \
        --minMAF=0 \
        --minMAC=20 \
        --LOCO=FALSE \
        --GMMATmodelFile=${STEP1_PREFIX}.rda \
        --SAIGEOutputFile=${OUTFILE}
done


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



# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251103_saige_hm3_comb/run_total_pheno_hm3_saige.sh

# lab-tasks submit-script --name saige-hm3-phe --path /mnt/arcus/lab/users/flynncarra/projects/20251103_saige_hm3_comb/run_total_pheno_hm3_saige.sh --split 410 --parallel 5 --cpu 4 --memory 55 --ett 48

# lab-tasks status scit1011-autism-gwas_saige-hm3-phe_4591