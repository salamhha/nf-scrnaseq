include { seuratImport } from '../modules/seurat-import.nf'

workflow {

    /*
    Seurat workflow
    */

    seuratImport()

}