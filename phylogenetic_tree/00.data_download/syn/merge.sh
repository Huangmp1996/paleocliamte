find co1/co1_download -name "*" -type f -size +0 |xargs -I {} cp -rf {} ../co1/co1_download
find cytb/cytb_download -name "*" -type f -size +0 |xargs -I {} cp -rf {} ../cytb/cytb_download
find 12S_RNA/12S_RNA_download -name "*" -type f -size +0 |xargs -I {} cp -rf {} ../12S_RNA/12S_RNA_download
find 16S_RNA/16S_RNA_download -name "*" -type f -size +0 |xargs -I {} cp -rf {} ../16S_RNA/16S_RNA_download
find ND1/ND1_download -name "*" -type f -size +0 |xargs -I {} cp -rf {} ../ND1/ND1_download
find ND2/ND2_download -name "*" -type f -size +0 |xargs -I {} cp -rf {} ../ND2/ND2_download