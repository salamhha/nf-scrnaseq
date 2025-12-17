process IMPORT_SEURAT{
    // 
    // Imports 10x matrix files into a Seurat object
    //    
    conda "${moduleDir}/../environment.yaml"

    publishDir 'results', mode: 'copy'

    input: 
    tuple val(sample_id), path(sample_dir)

    output: 
    tuple val(sample_id), path("${sample_id}_seurat-import.rds"), emit: seurat_import

    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)
    # Read 10X data into counts matrix
    data.counts <- Read10X(data.dir = "${sample_dir}")

    # Create Seurat object
    data.seurat <- CreateSeuratObject(counts = data.counts, project = "${sample_id}")
    # Add mitochondrial, ribosomal, and hemoglobin read percentage
    data.seurat[["percent.mt"]] <- PercentageFeatureSet(data.seurat, pattern = "^MT-")
    data.seurat[["percent.rb"]] <- PercentageFeatureSet(data.seurat, pattern = "^RPS|^RPL")
    data.seurat[["percent.hb"]] <- PercentageFeatureSet(data.seurat, pattern = "^HB[^(P)]")

    saveRDS(data.seurat, file = "${sample_id}_seurat-import.rds")
    """
}