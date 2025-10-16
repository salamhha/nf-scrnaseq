process seuratImport{

    //
    // Imports Seurat object
    //

    publishDir 'results', mode: 'copy'

    output:
        path "seurat-object.rds", emit: seurat_import
    
    script:
    """
    Rscript ./seurat-import.R
    """
}