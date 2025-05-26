cwlVersion: v1.2
class: CommandLineTool

baseCommand: [minimap2, -d, ref.mmi]

inputs:
  refs:
    type: File
    inputBinding:
      position: 1

outputs:
  mmi:
    type: File
    outputBinding:
      glob: ref.mmi
