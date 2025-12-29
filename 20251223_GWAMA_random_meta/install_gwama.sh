

#GWAMA_v2.2.2.zip  METAL  pheweb  PheWeb2  PheWeb2-API  R_libs  SAIGE  saige_env.yml  step2_SPAtests.R  v2


/mnt/arcus/lab/users/flynncarra/software/GWAMA/GWAMA


/mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/metal_results/meta_results_phe_313.1_1.txt
PROCESS /mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/leaf_metal_results/meta_results_phe_313.1_1.txt


awk 'BEGIN{FS=OFS="\t"} NR==1{print $0,"LowerCI","UpperCI"} 
NR>1{print $0, $4-1.96*$5, $4+1.96*$5}' \
/mnt/arcus/lab/users/flynncarra/projects/20251218_afr_phewas_hwe_1e6/metal_results/meta_results_phe_313.1_1.txt > /mnt/arcus/lab/users/flynncarra/projects/20251223_GWAMA_random_meta/afr_meta_results_phe_313.1_1.txt


awk 'BEGIN{FS=OFS="\t"} NR==1{print $0,"LowerCI","UpperCI"} 
NR>1{print $0, $4-1.96*$5, $4+1.96*$5}' \
/mnt/arcus/lab/users/flynncarra/projects/20251215_hwe_1e6_eur/leaf_metal_results/meta_results_phe_313.1_1.txt > /mnt/arcus/lab/users/flynncarra/projects/20251223_GWAMA_random_meta/eur_meta_results_phe_313.1_1.txt

ls /mnt/arcus/lab/users/flynncarra/projects/20251223_GWAMA_random_meta/*.txt > /mnt/arcus/lab/users/flynncarra/projects/20251223_GWAMA_random_meta/adhd_file_list.txt


cd /mnt/arcus/lab/users/flynncarra/projects/20251223_GWAMA_random_meta/

/mnt/arcus/lab/users/flynncarra/software/GWAMA/GWAMA \
--filelist /mnt/arcus/lab/users/flynncarra/projects/20251223_GWAMA_random_meta/adhd_file_list.txt \
--name_marker MarkerName \
--name_ea Allele1 \
--name_nea Allele2 \
--name_beta Effect \
--name_se StdErr \
--random \
--output meta_results_phe_313.1_1.GWAMA