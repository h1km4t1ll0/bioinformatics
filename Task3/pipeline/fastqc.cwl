cwlVersion: v1.2
class: CommandLineTool

baseCommand: [fastqc]

inputs:
  reads:
    type: File
    inputBinding:
      position: 1

arguments:
  - valueFrom: "--outdir=./"

outputs:
  qc_report:
    type: File
    outputBinding:
      glob: "*.html"
