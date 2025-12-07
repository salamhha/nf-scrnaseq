nextflow.enable.dsl=2

include { IMPORT_SCANPY } from '../modules/scanpy/import/main.nf'
include { FILTER_SCANPY } from '../modules/scanpy/filter/main.nf'

workflow {
    input_ch = channel
                    .fromPath(params.input_data, type: 'dir')
                    .map { dir -> tuple(dir.baseName, dir) }

    IMPORT_SCANPY(input_ch)
    
    FILTER_SCANPY(IMPORT_SCANPY.out.scanpy_import)

}