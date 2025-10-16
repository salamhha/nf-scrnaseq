include { seuratImport } from '../modules/seurat-import.nf'

params.input_data = "data/pbmc3k/"

workflow {
	
    input_ch = Channel.fromPath(params.input_data)

    /*
    Seurat workflow
    */

    seuratImport(input_ch)

}
