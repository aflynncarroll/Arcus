#!/usr/bin/env bash

# ----------------------------
# Paths
# ----------------------------
VCF_DIR=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom
OUT_DIR=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_chrom/shared_var
#VARIANT_LIST=/mnt/arcus/lab/users/flynncarra/projects/20251029_variants_by_array/array_common_vars.txt
VARIANT_LIST=/mnt/arcus/lab/users/flynncarra/projects/20251029_variants_by_array/array_common_vars_chr22_filt.txt
#mkdir -p $OUT_DIR

# ----------------------------
# Loop over chromosomes 1-22
# ----------------------------
for CHR in {1..22}; do
    IN_VCF=${VCF_DIR}/eur_5_chr${CHR}.vcf.gz
    OUT_VCF=${OUT_DIR}/eur_5_com_chr${CHR}.vcf.gz

    echo "Filtering chromosome $CHR VCF..."

    # Subset variants using bcftools and compress output
    bcftools view -T $VARIANT_LIST -Oz -o $OUT_VCF $IN_VCF

    # Index the filtered VCF with CSI
    tabix -p vcf $OUT_VCF

    echo "Chromosome $CHR done: $OUT_VCF + ${OUT_VCF}.csi"
done

echo "All chromosomes filtered and indexed."

bcftools query -f '%ID\n' $IN_VCF | head



bcftools view -R $VARIANT_LIST -h $IN_VCF

bcftools query -f '%ID\n' $IN_VCF > chr22_var.txt
