process seuratImport{

    //
    // Imports Seurat object
    //

    publishDir 'results', mode: 'copy'

    input: 
	path input_data

    output:
        path "01_seurat-import.rds", emit: seurat_import
    
    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)
    data.counts <- Read10X(data.dir = '$input_data')
    data <- CreateSeuratObject(counts = data.counts, project = "pbmc3k",
                            min.cells = 3, min.features = 200)
    saveRDS(data, file = "01_seurat-import.rds")
    """
}
