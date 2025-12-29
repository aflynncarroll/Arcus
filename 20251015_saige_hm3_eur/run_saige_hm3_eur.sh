  #!/bin/bash

conda activate saige_env


# location of step1 and step2 files
# /mnt/arcus/lab/users/flynncarra/software/SAIGE/extdata/


Rscript /mnt/arcus/lab/users/flynncarra/software/SAIGE/extdata/step1_fitNULLGLMM.R \
    --useSparseGRMtoFitNULL=FALSE \
    --plinkFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total \
    --phenoFile=/mnt/arcus/lab/users/flynncarra/projects/20251008_phewas_saige_pheno/array_eur_total_phe_200.tsv \
    --skipVarianceRatioEstimation=FALSE \
    --phenoCol=phe_313.3 \
    --covarColList=age,age_sqr,sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10 \
    --sampleIDColinphenoFile=biosample_id \
    --traitType=binary \
    --outputPrefix=/mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/HM3_EUR_R_SAIGE_step1_GLMM_binary_sparseGRM_vr \
    --IsOverwriteVarianceRatioFile=FALSE


bcftools index /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz

#Rscript /mnt/arcus/lab/users/flynncarra/software/SAIGE/extdata/step2_SPAtests.R \
for CHR in {1..22}; do
Rscript /home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata/step2_SPAtests.R \
        --vcfFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz  \
        --vcfFileIndex=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz.csi  \
        --vcfField=GT   \
        --SAIGEOutputFile=/mnt/arcus/lab/project/data/interim/total_eur/HM3_EUR_R_SAIGE_phe_313.3_vcf.txt \
        --chrom=$CHR \
        --minMAF=0 \
        --minMAC=20 \
        --LOCO=FALSE \
        --GMMATmodelFile=/mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/HM3_EUR_R_SAIGE_step1_GLMM_binary_sparseGRM_vr.rda \
        --SAIGEOutputFile /mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/eur_phe_313.3_chr${CHR}.txt \

        done





Rscript /mnt/arcus/lab/users/flynncarra/software/SAIGE/extdata/install_packages.R

pixi run  --manifest-path=/home/flynncarra/software/SAIGE/pixi.toml  R CMD INSTALL SAIGE --library=/home/flynncarra/software/R_libs

conda env create -f saige_env.yml -n saige_env
