nextflow.enable.dsl=2

include { IMPORT_SEURAT } from '../modules/seurat/import/main.nf'
include { FILTER_SEURAT } from '../modules/seurat/filter/main.nf'

workflow {
    input_ch = channel
                    .fromPath(params.input_data, type: 'dir')
                    .map { dir -> tuple(dir.baseName, dir) }

    IMPORT_SEURAT(input_ch)

    FILTER_SEURAT(IMPORT_SEURAT.out.seurat_import)


}