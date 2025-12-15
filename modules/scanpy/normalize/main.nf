process NORMALIZE_SCANPY{
    // 
    // Normalizes counts using scanpy log-normalization
    //    
    conda "${moduleDir}/../environment.yaml"

    publishDir 'results', mode: 'copy'

    input:
    tuple val(sample_id), path(input_data)

    output:
    tuple val(sample_id), path("${sample_id}_scanpy-normalize.h5ad"), emit: scanpy_normalize
    
    script:
    """
    #!/usr/bin/env python3
    import scanpy as sc
    adata = sc.read_h5ad("${input_data}")
    # Saving count data
    adata.layers["counts"] = adata.X.copy()
    # Normalizing to median total counts
    sc.pp.normalize_total(adata)
    # Logarithmize the data
    sc.pp.log1p(adata)
    adata.write("${sample_id}_scanpy-normalize.h5ad")
    """
}

