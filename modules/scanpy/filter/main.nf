process FILTER_SCANPY{
    //
    // Filters Scanpy object
    //
    conda "${moduleDir}/../environment.yaml"

    publishDir 'results', mode: 'copy'

    input:
    tuple val(sample_id), path(input_data)

    output:
    tuple val(sample_id), path("${sample_id}_scanpy-filter.h5ad"), emit: scanpy_filter

    script:
    """
    #!/usr/bin/env python
    import scanpy as sc

    adata = sc.read_h5ad("${input_data}")
    
    # Filter cells with fewer than min_genes
    sc.pp.filter_cells(adata, min_genes=${params.filter.min_genes})
    # Filter genes with fewer than min_cells
    sc.pp.filter_genes(adata, min_cells=${params.filter.min_cells})
    # Filter cells with mitochondrial read % > max_mt_percent
    adata = adata[adata.obs['pct_counts_mt'] < ${params.filter.max_mt_pct}, :]
    # Filter cells with gene count > max_genes
    adata = adata[(adata.obs['n_genes_by_counts'] < ${params.max_genes}), :]

    adata.write("${sample_id}_scanpy-filter.h5ad")
    """        
}