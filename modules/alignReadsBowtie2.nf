process BOWTIE2 {

    // Directives
    container 'staphb/bowtie2'
    tag "$sample_id"

    // [sample_ID, [read1, read2]]
    input:
    tuple val(sample_id), path(reads)
    path genome_index_files

    output:
    tuple val(sample_id), path("${sample_id}.bt.bam")

    script:
    """
    bowtie2 -p ${params.cpus} -x ${params.genome_file} -1 ${reads[0]} -2 ${reads[1]} -S ${sample_id}.sam
    samtools view -@ ${params.cpus} -b ${sample_id}.sam > ${sample_id}.bam
    rm ${sample_id}.sam
    """
}