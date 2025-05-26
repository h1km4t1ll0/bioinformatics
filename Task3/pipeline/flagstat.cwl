cwlVersion: v1.2
class: CommandLineTool

baseCommand: [samtools, flagstat]

inputs:
  samfile:
    type: File
    inputBinding:
      position: 1

outputs:
  flagstat_out:
    type: stdout

stdout: flagstat.txt
