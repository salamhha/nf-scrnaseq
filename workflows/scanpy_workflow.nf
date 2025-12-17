nextflow.enable.dsl=2

include { IMPORT_SCANPY } from '../modules/scanpy/import/main.nf'
include { PLOT_QC_SCANPY } from '../modules/scanpy/plot-qc/main.nf'
include { FILTER_SCANPY } from '../modules/scanpy/filter/main.nf'
include { NORMALIZE_SCANPY } from '../modules/scanpy/normalize/main.nf'
include { MERGE_SCANPY } from '../modules/scanpy/merge/main.nf'

workflow {
    input_ch = channel
                    .fromPath(params.input_data, type: 'dir')
                    .map { dir -> tuple(dir.baseName, dir) }

    IMPORT_SCANPY(input_ch)

    PLOT_QC_SCANPY(IMPORT_SCANPY.out.scanpy_import)
    
    FILTER_SCANPY(IMPORT_SCANPY.out.scanpy_import)

    NORMALIZE_SCANPY(FILTER_SCANPY.out.scanpy_filter)

    // Checks if more than 1 sample is present for merge
    merge = NORMALIZE_SCANPY.out.scanpy_normalize
                             .map { id, h5 -> h5 } // Keep paths
                             .collect() 
                             .filter { paths -> paths.size() > 1 } // drops if only 1 sample
    MERGE_SCANPY(merge)
    
    downstream_input = MERGE_SCANPY.out.scanpy_merge.ifEmpty { NORMALIZE_SCANPY.out.scanpy_normalize }
    
    

}