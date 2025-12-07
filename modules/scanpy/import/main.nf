process IMPORT_SCANPY{
    tag { sample_id }
    // 
    // Imports 10x matrix files into anndata using scanpy
    //    
    conda "${moduleDir}/../environment.yaml"

    publishDir 'results', mode: 'copy'

    input: 
    tuple val(sample_id), path(sample_dir)

    output: 
    tuple val(sample_id), path("${sample_id}_01_scanpy-import.h5ad"), emit: scanpy_import

    script:
    """
    #!/usr/bin/env python
    import scanpy as sc

    adata = sc.read_10x_mtx("${sample_dir}")
    # adata.obs["sample"] = sample # Add sample identity

    # Calculate base QC Metrics
    adata.var["mt"] = adata.var_names.str.startswith("MT-")
    adata.var["ribo"] = adata.var_names.str.startswith(("RPS", "RPL"))
    adata.var["hb"] = adata.var_names.str.contains("^HB[^(P)]")
    sc.pp.calculate_qc_metrics(adata, qc_vars=["mt", "ribo", "hb"], inplace=True, log1p=True)

    adata.write("${sample_id}_01_scanpy-import.h5ad")
    """
}