#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MANTA_SOMATIC } from '../../../../modules/manta/somatic/main.nf'

workflow test_manta_somatic {

    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_recalibrated_sorted_cram'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_recalibrated_sorted_cram_crai'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test2_paired_end_recalibrated_sorted_cram'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test2_paired_end_recalibrated_sorted_cram_crai'], checkIfExists: true)
    ]

    fasta   = file(params.test_data['homo_sapiens']['genome']['genome_fasta'], checkIfExists: true)
    fai     = file(params.test_data['homo_sapiens']['genome']['genome_fasta_fai'], checkIfExists: true)
    bed     = file(params.test_data['homo_sapiens']['genome']['genome_bed_gz'], checkIfExists: true)
    bed_tbi = file(params.test_data['homo_sapiens']['genome']['genome_bed_gz_tbi'], checkIfExists: true)

    MANTA_SOMATIC ( input, fasta, fai, bed, bed_tbi )
}
