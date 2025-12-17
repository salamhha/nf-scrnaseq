process PLOT_QC_SEURAT{
    // 
    // Plots QC Metrics in Seurat
    //    
    conda "${moduleDir}/../environment.yaml"

    publishDir 'results', mode: 'copy'

    input: 
    tuple val(sample_id), path(input_data)

    output: 
    path("${sample_id}_seurat-qc-plot.png")

    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)
    library(patchwork)

    # Read Seurat object
    data.seurat <- readRDS("${input_data}")
    plot1 <- VlnPlot(data.seurat, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
    plot2 <- FeatureScatter(data.seurat, feature1 = "nCount_RNA", feature2 = "percent.mt")
    plot3 <- FeatureScatter(data.seurat, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")

    png(filename = "${sample_id}_seurat-qc-plot.png", width = 1200, height = 1000, res = 150)
    plot1 / (plot2 + plot3)
    dev.off()
    """
}



