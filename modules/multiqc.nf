process MULTI_QC {

    // Directives
    container 'multiqc/multiqc'
    publishDir("${params.outdir}/FASTQC", mode: 'copy', overwrite: true)

    input:
    path (inputfiles)

    output:
    path "multiqc_report.html"					

    script:
    """
    multiqc .
    """
}
