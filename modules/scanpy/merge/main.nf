process MERGE_SCANPY{
    // 
    // Merges samples if multiple samples are present
    //    
    conda "${moduleDir}/../environment.yaml"

    publishDir 'results', mode: 'copy'

    input:
    path(input_data)

    output:
    tuple val("merged"), path("merged_scanpy-merge.h5ad"), emit: scanpy_merge

    script:
    """
    #!/usr/bin/env python3
    import scanpy as sc
    from pathlib import Path

    inputs = [${input_data.collect { p -> "Path('${p}')"}.join(', ')}]
    adatas = [sc.read_h5ad(p) for p in inputs]
    merged_adata = sc.concat(adatas, join="outer", label="sample", index_unique="-")
    merged_adata.var_names_make_unique()
    merged_adata.write("merged_scanpy-merge.h5ad")
    """
}

