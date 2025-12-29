#!/usr/bin/env bash

cd /home/flynncarra/projects/20251215_hwe_1e6_eur/

/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/eaa8d6126d

/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/1c18651582

/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/34505c4e9a

/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/3b4102e323

/mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/e9229326cc


plink \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_eaa8d6126d \
  --hwe 1e-6 \
  --write-snplist  \
  --out eaa8d6126d_hwe_var

# Before frequency and genotyping pruning, there are 605475 SNPs
# 2123 founders and 0 non-founders found
# 807 markers to be excluded based on HWE test ( p <= 1e-06 )

plink \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_1c18651582 \
  --hwe 1e-6 \
  --write-snplist \
  --out 1c18651582_hwe_var
  
# Before frequency and genotyping pruning, there are 506359 SNPs
# 4072 founders and 0 non-founders found
# 1374 markers to be excluded based on HWE test ( p <= 1e-06 )

  plink \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_34505c4e9a \
  --hwe 1e-6 \
  --write-snplist \
  --out 34505c4e9a_hwe_var

# Before frequency and genotyping pruning, there are 603659 SNPs
# 2098 founders and 0 non-founders found
# 506 markers to be excluded based on HWE test ( p <= 1e-10 )
# 970 markers to be excluded based on HWE test ( p <= 1e-06 )

  plink \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_3b4102e323 \
  --hwe 1e-6 \
  --write-snplist \
  --out 3b4102e323_hwe_var

# Before frequency and genotyping pruning, there are 599126 SNPs
# 2915 founders and 0 non-founders found
# 412 markers to be excluded based on HWE test ( p <= 1e-10 )
# 757 markers to be excluded based on HWE test ( p <= 1e-06 )

  plink \
  --bfile /mnt/arcus/lab/project/data/interim/batch2/indv_array_phewas/EUR_MAF05_g2_m2_e9229326cc \
  --hwe 1e-6 \
  --write-snplist \
  --out e9229326cc_hwe_var

# Before frequency and genotyping pruning, there are 716044 SNPs
# 1516 founders and 0 non-founders found
# 230 markers to be excluded based on HWE test ( p <= 1e-10 )
# 514 markers to be excluded based on HWE test ( p <= 1e-06 )
######################
# format filter files
######################

cut -f2 eaa8d6126d_hwe_var.snplist > eaa8d6126d_hwe_var.txt

cut -f2 1c18651582_hwe_var.snplist > 1c18651582_hwe_var.txt

cut -f2 34505c4e9a_hwe_var.snplist > 34505c4e9a_hwe_var.txt

cut -f2 3b4102e323_hwe_var.snplist > 3b4102e323_hwe_var.txt

cut -f2 e9229326cc_hwe_var.snplist > e9229326cc_hwe_var.txt

######################
# filter SAIGE output
######################

mkdir /home/flynncarra/projects/20251215_hwe_1e6_eur/saige_results




awk 'NR==FNR {keep[$1]; next} FNR==1 {print; next} $3 in keep' \
1c18651582_hwe_var.txt \
/mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array/results/1c18651582_phe_1001_allchr.txt \
> /home/flynncarra/projects/20251211_hwe_results_filter/saige_results/1c18651582_phe_1001_allchr.txt


wc -l /mnt/arcus/lab/users/flynncarra/projects/20251205_rolled_up_phecode_saige_array/results/1c18651582_phe_1001_allchr.txt

wc -l /home/flynncarra/projects/20251211_hwe_results_filter/saige_results/1c18651582_phe_1001_allchr.txt