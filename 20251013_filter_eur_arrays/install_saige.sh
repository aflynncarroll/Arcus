    #!/bin/bash

    cd /mnt/arcus/lab/users/flynncarra/software
    
    src_branch=main
    repo_src_url=https://github.com/saigegit/SAIGE
    git clone --depth 1 -b $src_branch $repo_src_url
    Rscript ./SAIGE/extdata/install_packages.R
    R CMD INSTALL --library=path_to_final_SAIGE_library SAIGE

# location of step1 and step2 files
    /mnt/arcus/lab/users/flynncarra/software/SAIGE/extdata/