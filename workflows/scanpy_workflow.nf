
nextflow.enable.dsl=2
// NXF_SYNTAX_PARSER=v2

include { IMPORT_SCANPY } from '../modules/scanpy/import/main.nf'

/* params {
    // path to input data
    input_data: Path

}*/
params.input_data = "data/pbmc3k/" 

workflow {
    input_ch = Channel.fromPath(params.input_data)

    IMPORT_SCANPY(input_ch)
}