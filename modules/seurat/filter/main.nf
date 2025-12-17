process FILTER_SEURAT{
    // 
    // Filters Seurat object
    //    
    conda "${moduleDir}/../environment.yaml"

    publishDir 'results', mode: 'copy'

    input: 
    tuple val(sample_id), path(input_data)

    output: 
    tuple val(sample_id), path("${sample_id}_seurat-filter.rds"), emit: seurat_filter

    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)

    # Read Seurat object
    data.seurat <- readRDS("${input_data}")

    # Filter genes expressed in fewer than min_cells
    counts <- GetAssayData(data.seurat, layer = "counts")
    genes.keep <- rownames(counts)[rowSums(counts > 0) >= ${params.filter.min_cells}]
    data.seurat <- subset(data.seurat, features = genes.keep)

    # Filter cells by feature count and mitochondrial read count
    data.seurat <- subset(data.seurat, subset = nFeature_RNA >= ${params.filter.min_genes} & nFeature_RNA < ${params.filter.max_genes} & percent.mt < ${params.filter.max_mt_pct})

    saveRDS(data.seurat, "${sample_id}_seurat-filter.rds")
    """
}

