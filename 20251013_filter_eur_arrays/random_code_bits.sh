bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\n' EUR_MAF05_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz | head



gsutil ls -lh gs://scit1011-autism-gwas-b3-def/lab/output/lijj/20250701B2/03_ancestry_calling/merge5arrays_NoCaseFilter/


gsutil mb gs://scit1011-autism-gwas-b3-def/lab/afc/

gsutil cp /home/flynncarra/projects/20251010_google_bucket/test.txt gs://scit1011-autism-gwas-b3-def/lab/afc/


gsutil ls -lh gs://scit1011-autism-gwas-b3-def/lab/afc/

ls /mnt/arcus/lab/project/data/interim/batch1_2/


gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_1c18651582.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/


gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_34505c4e9a.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/



gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_3b4102e323.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/


gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_e9229326cc.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/


gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/

gsutil cp /mnt/arcus/lab/project/data/interim/batch1_2/EUR_SCIT1011-AUTISM-GWAS_eaa8d6126d.vcf.gz.tbi gs://scit1011-autism-gwas-b3-def/lab/afc/EUR_Array/




Rscript step1_fitNULLGLMM.R \
    --plinkFile=$working_data/variants.pruned.extracted \
    --phenoFile=$working_data/SAIGE.phenotypes_covariates.txt \
    --phenoCol=autism \
    --traitType=binary \
    --covarColList=age,${pclist},batch,sex \
    --qCovarColList=batch,sex \
    --sampleIDColinphenoFile=iid \
    --minMAFforGRM=0.01 \
    --nThreads=$threads \
    --IsOverwriteVarianceRatioFile=TRUE \
    --outputPrefix=$working_data/step1.genopcs_20_sex.corrected

Rscript step2_SPAtests.R \
        --vcfFile=$working_data/chr${chrom}.dose.bcf \
        --vcfFileIndex=$working_data/chr${chrom}.dose.bcf.csi \
        --is_imputed_data=TRUE \
        --minMAF=0.01 \
        --maxMissing=0.05 \
        --chrom=${chrom} \
        --GMMATmodelFile=$working_data/step1.genopcs_20.rda \
        --varianceRatioFile=$working_data/step1.genopcs_20.varianceRatio.txt \
        --SAIGEOutputFile=$working_data/step2.genopcs_20.chr${chrom} \
        --is_Firth_beta=TRUE \
        --pCutoffforFirth=0.05 \
        --is_output_moreDetails=TRUE


        mkdir /mnt/arcus/lab/project/data/interim/total_eur




gsutil cp gs://scit1011-autism-gwas-b3-def/lab/output/lijj/20250701B2/03_ancestry_calling/merge5arrays_NoCaseFilter/merged_a1.a2.a3.a4.a5.bed /mnt/arcus/lab/project/data/interim/total_eur
gsutil cp gs://scit1011-autism-gwas-b3-def/lab/output/lijj/20250701B2/03_ancestry_calling/merge5arrays_NoCaseFilter/merged_a1.a2.a3.a4.a5.bim /mnt/arcus/lab/project/data/interim/total_eur
gsutil cp gs://scit1011-autism-gwas-b3-def/lab/output/lijj/20250701B2/03_ancestry_calling/merge5arrays_NoCaseFilter/merged_a1.a2.a3.a4.a5.fam /mnt/arcus/lab/project/data/interim/total_eur 

Rscript /home/flynncarra/software/v2/v3/SAIGE-1.3.3/extdata/step2_SPAtests.R \
    --vcfFile=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz  \
    --vcfFileIndex=/mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz.csi  \
    --vcfField=GT   \
    --SAIGEOutputFile=/mnt/arcus/lab/project/data/interim/total_eur/HM3_EUR_R_SAIGE_phe_313.3_vcf.txt \
    --chrom=1 \
    --minMAF=0 \
    --minMAC=20 \
    --LOCO=FALSE \
    --GMMATmodelFile=/mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/HM3_EUR_R_SAIGE_step1_GLMM_binary_sparseGRM_vr.rda \
    --SAIGEOutputFile=/mnt/arcus/lab/users/flynncarra/projects/20251015_saige_hm3_eur/eur_phe_313.3_chr1.txt 


    bcftools view -H /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_hm3_total.vcf.gz | wc -l

   plink --bfile /mnt/arcus/lab/project/data/interim/total_eur/merged_a1.a2.a3.a4.a5 --write-snplist --out /mnt/arcus/lab/project/data/interim/total_eur/merged_a1.a2.a3.a4.a5


bcftools stats /mnt/arcus/lab/project/data/interim/total_eur/eur_0.05_array_total.vcf.gz | grep "^SN" | grep "number of SNPs"
