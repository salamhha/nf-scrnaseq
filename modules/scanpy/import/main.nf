process IMPORT_SCANPY{
    // 
    // Imports 10x matrix files into anndata using scanpy
    //    
    conda "${moduleDir}/environment.yml"

    publishDir 'results', mode: 'copy'

    input: 
    path input_data

    output: 
    path "01_scanpy-import.h5ad", emit: scanpy_import

    script:
    """
    #!/usr/bin/env python
    import scanpy as sc

    adata = sc.read_10x_mtx("$input_data")
    sc.write(filename="01_scanpy-import.h5ad", adata=adata)
    """
}