process FILTER_SCANPY{
    //
    // Filters Scanpy object
    //
    conda "${moduleDir}/../environment.yaml"

    publishDir 'results', mode: 'copy'

    input:
    tuple val(sample_id), path(input_data)

    output:
    tuple val(sample_id), path("${sample_id}_02_scanpy-filter.h5ad"), emit: scanpy_filter

    script:
    """
    #!/usr/bin/env python
    import scanpy as sc

    adata = sc.read_h5ad("${input_data}")
    
    sc.pp.filter_cells(adata, min_genes=500)
    sc.pp.filter_genes(adata, min_cells=200)
    adata = adata[adata.obs['pct_counts_mt'] < 5, :]

    adata.write("${sample_id}_02_scanpy-filter.h5ad")
    """        
}