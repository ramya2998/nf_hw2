#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.reads = "/path/to/your/files/SRR11192680_{1,2}.fastq.gz" // Update this to the actual path where the files are stored on user's system.
params.outdir = 'Outputs'

// Create a channel for the specific pair of reads
read_pairs = Channel.fromPath(params.reads)

// Assembly with SKESA
process assembly {
    tag "${id}"

    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(id), path(read1), path(read2)

    output:
    tuple val(id), path("${id}_assembled.fasta"), emit: assembly_out

    script:
    """
    skesa --fastq ${read1},${read2} --contigs_out ${id}_assembled.fasta
    """
}

// Quality Assessment using QUAST
process quality_assessment {
    input:
    tuple val(id), path(assembly_out)
    
    output:
    path("${id}_quast_report")

    script:
    """
    mkdir ${id}_quast_report
    quast.py "${assembly_out}" --min-contig 100 -o ${id}_quast_report
    """
}

// Genotyping with MLST
process genotyping {
    input: 
    tuple val(id), path(assembly_out)

    output:
    path("${id}_MLST_Summary.tsv")

    script:
    """
    mlst "${assembly_out}" > ${id}_MLST_Summary.tsv
    """
}

workflow {
    // Telling the system to execute processes in a defined order
    assem = assembly(read_pairs)
    qa = quality_assessment(assem)
    genotyping(assem)
}
