
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
WORKDIR=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/
VCF_PREFIX=eur_5_chr
VCF_EXT=.vcf.gz

cd $WORKDIR

# ----------------------------
# Determine chromosome for this job
# ----------------------------
# SPLIT_ID=1
CHR=$SPLIT_ID
echo "Indexing chromosome $CHR ..."

VCF_FILE=${VCF_PREFIX}${CHR}${VCF_EXT}

# ----------------------------
# Create CSI index
# ----------------------------
bcftools index --c $VCF_FILE




# for f in eur_5_chr*.vcf.gz; do
#     echo "Indexing $f ..."
#     bcftools index -c "$f"
# done

# chmod +x /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/index_vcfs.sh

# lab-tasks submit-script --name index-vcfgz --path /mnt/arcus/lab/users/flynncarra/projects/20251021_total_var_SAIGE/index_vcfs.sh --split 22 --parallel 5 --cpu 4 --memory 40 --ett 4

# lab-tasks status scit1011-autism-gwas_index-vcfgz_9952