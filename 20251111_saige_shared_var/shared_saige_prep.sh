# ----------------------------
# Initialize environment
# ----------------------------
. ~/.bashrc
eval "$(conda shell.bash hook)"
conda activate plink2_env

# ----------------------------
# create vcf file
# ----------------------------

plink2 --bfile /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared \
       --recode vcf \
       --out /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared


# ----------------------------
# Compress to .vcf.gz
# ----------------------------

bcftools view -Oz -o \
    /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared.vcf.gz \
    /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared.vcf


# ----------------------------
# Create CSI index
# ----------------------------

bcftools index --c /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared.vcf.gz


conda activate saige_env



 Rscript /home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata/createSparseGRM.R       \
     --plinkFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_0.05_shared \
     --nThreads=4  \
     --outputPrefix=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var/eur_5_shared      \
     --numRandomMarkerforSparseKin=2000      \
     --relatednessCutoff=0.125

