# GT Computational Genomics 7210: NextFlow HW2

## Genome Assembly and Analysis Pipeline
The following NextFlow pipeline performs genome assembly using SKESA, quality assessment with QUAST, and genotyping using MLST. It is designed to process paired-end FASTQ files from Illumina sequencing.

### Prerequisites
To use this pipeline, you must have the following tools installed on your system:
- Nextflow: Version 20.04.1 (or later)
- SKESA: available from GitHub (https://github.com/ncbi/SKESA)
- QUAST: Install via bioconda with the command 'conda install -c bioconda quast'
- MLST: Install via bioconda with the command 'conda install -c bioconda mlst'

### Installation
1. Clone the repo into your local machine or download the .nf script.
2. Prepare the environment. In other words, make sure that all the required tools are installed and accessible in the script PATH.

#### Files being input:
The paired-ends reads in 'fasta.gz' format are being used as input in this pipeline. They should be named as follows in order to be executable:
- '{sample}_1.fastq.gz'
- '{sample}_2.fastq.gz'

### Configuration
Before running the provided pipeline, make sure to update the 'params.reads' variable in the script to point to wherever you have your FASTQ files stored.

### Running the pipeline
Execute the pipeline using the following command: 'nextflow run workflow_hw2.nf'
- This command will start processing the pipeline with the given parameters. It will execute 3 stages:
  1. Assembly: assmebling the genomes from FASTQ files using SKESA.
  2. Quality Assessment: evaluate assembly quality using QUAST.
  3. Genotyping: use MLST on the assembled genomes.

### Outputs
The pipeline generates the following outputs in the 'Outputs' directory:
- assembled FASTA genomes
- QUAST quality assessment reports
- MLST genotyping summary tables
