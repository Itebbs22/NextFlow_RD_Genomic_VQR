process BOWTIE_INDEX {

    if (params.platform == 'local') {
        label 'process_low'
    } else if (params.platform == 'cloud') {
        label 'process_medium'
    }

    // Publish indexed files to the specified directory
    publishDir("$params.outdir/BOWTIE_GENOME_IDX", mode: "copy")

    input:
    path genomeFasta

    output:
    tuple path(genomeFasta), path("${genomeFasta}.*")

    script:
    """
    echo "Building bowtie2 index files"

    ref_name=\$(basename ${genomeFasta})

    bowtie2-build "${genomeFasta}" \$ref_name

    echo "Genome Indexing complete."
    """
}

