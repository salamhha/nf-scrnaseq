#!/usr/bin/env Rscript
library(Seurat)
data.counts <- Read10X(data.dir = "../data/pbmc3k-dataset")
data <- CreateSeuratObject(counts = data.counts, project = "pbmc3k",
                            min.cells = 3, min.features = 200)
saveRDS(data, file = "import-seurat.rds")