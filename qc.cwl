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
  coverage_file:
    type: File
    inputBinding:
      prefix: "--tcove"
      position: 1
  fastp_file:
    type: File
    inputBinding:
      prefix: "--tjson"
      position: 2
  sample_name:
    type: string

baseCommand: [python, /opt/huindata/QC/FP_BAMDST.py]

arguments:
  - prefix: --outfile
    valueFrom: $(inputs.sample_name).qc.csv

outputs:
  out_qc:
    type: File
    outputBinding:
      glob: "*.qc.csv"
