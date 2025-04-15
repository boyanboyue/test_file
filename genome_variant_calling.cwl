#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: "library/huin-gatk4:4.4.0.0"
  ResourceRequirement:
    ramMin: 63488
    coresMin: 16

inputs:
  genome:
    type: string
    inputBinding:
      prefix: "-g"
      position: 1
  bed:
    type: File?
    inputBinding:
      prefix: "-b"
      position: 2
  sample_name:
    type: string
    inputBinding:
      prefix: "-s"
      position: 3

  fastq:
    type: File[]
    inputBinding:
      position: 4

baseCommand: [bash, /opt/huindata/germline/gatk_germline_wgs_single.sh]
outputs:
  out_bam:
    type: File
    outputBinding:
      glob: $(inputs.sample_name).sorted.marked_duplicates.bam
    secondaryFiles: [ .bai ]
  out_vcf:
    type: File
    outputBinding:
      glob: "*.vcf.gz"
  out_coverage:
    type: File
    outputBinding:
      glob: $(inputs.sample_name).report
  out_fastp:
    type: File
    outputBinding:
      glob: $(inputs.sample_name).json
  # out_qc:
  #   type: File
  #   outputBinding:
  #     glob: "*.qc.csv"
