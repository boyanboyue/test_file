#!/usr/bin/env cwl-runner
cwlVersion: v1.2
class: Workflow
label: germline-genome

requirements:
  ScatterFeatureRequirement: {}
  SubworkflowFeatureRequirement: {}
  MultipleInputFeatureRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  fastq: File[]
  genome: string?
  sample_name: string?
  bed: File

outputs:
# bam file
  out_bam:
    type: File
    outputSource: exon_variant_calling/out_bam
  out_vcf:
    type: File
    outputSource: exon_variant_calling/out_vcf
  out_coverage:
    type: File
    outputSource: exon_variant_calling/out_coverage
  out_fastp:
    type: File
    outputSource: exon_variant_calling/out_fastp
  out_qc:
    type: File
    outputSource: qc/out_qc
steps:
  exon_variant_calling:
    run: exon_variant_calling.cwl
    in:
      fastq: fastq
      genome: genome
      sample_name: sample_name
      bed: bed
    out: [out_bam,out_vcf,out_coverage,out_fastp]

  qc:
    run: qc.cwl
    in:
      coverage_file: exon_variant_calling/out_coverage
      fastp_file: exon_variant_calling/out_fastp
      sample_name: sample_name
    out: [out_qc]
