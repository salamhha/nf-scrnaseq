nextflow.enable.dsl=2

include { IMPORT_SEURAT } from '../modules/seurat/import/main.nf'

workflow {
    input_ch = channel
                    .fromPath(params.input_data, type: 'dir')
                    .map { dir -> tuple(dir.baseName, dir) }

    IMPORT_SEURAT(input_ch)

}