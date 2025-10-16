process import_dataset{
    //
    // Imports dataset using SCTK package
    //

    publishDir 'results', mode: 'copy'

    input:
        path "data/pbmc3k-dataset/"
    
    output:
        path "results/imported-data.rds", emit: imported_data

    script:
    """
    Rscript scripts/sctk-import.R
    """
}