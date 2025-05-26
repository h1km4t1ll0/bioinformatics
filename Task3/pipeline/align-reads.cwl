cwlVersion: v1.2
class: CommandLineTool

baseCommand: [minimap2, -a, -t, "16"]

inputs:
  refs_index:
    type: File
    inputBinding:
      position: 1
  reads:
    type: File
    inputBinding:
      position: 2

outputs:
  samfile:
    type: File
    outputBinding:
      glob: aligned_reads.sam

stdout: aligned_reads.sam