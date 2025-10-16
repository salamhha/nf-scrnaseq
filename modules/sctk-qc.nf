process SCTK_QC {

    //
    // This module runs QC tools from the SCTK package
    //

    container 'campbio/sctk_qc:latest'

    publishDir 'results', mode: 'symlink'

    def qc_output = "sctk_qc_output"

    input:
        path dataset
        val params
    
    output:
        path qc_output
    
    script:
    """
    docker run --rm -v /path/to/data:/SCTK_docker \
    -it campbio/sctk_qc:2.18.0 \
    -b /SCTK_docker/cellranger_folder \
    -P CellRangerV3 \
    -s ${} \
    -o $qc_output \
    -S TRUE \
    -F SCE,AnnData,FlatFile,Seurat
    """
}