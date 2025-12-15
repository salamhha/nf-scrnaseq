# nf-scrnaseq
Nextflow Workflow for scRNAseq analysis. Assumes an input of matrix files in the 10x Genomics style. The package includes two example datasets, pbmc3k and pbmc8k.

## Usage
```bash
nextflow run workflows/scanpy_workflow.nf -profile test
```