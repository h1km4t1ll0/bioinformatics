cwlVersion: v1.2
class: CommandLineTool

baseCommand: [bash, analyze-mapping.sh]

inputs:
  flagstat_text:
    type: File
    inputBinding:
      position: 1

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: analyze-mapping.sh
        entry: |
          #!/bin/bash
          result=\$(grep -oP 'mapped \(\K[\d.]+' "$1" | head -1)
          if [ -n "\$result" ]; then
              echo "Mapped $result%"
              check=`echo "\$result > 90.0" | bc -l`
              if [ $check -eq 1 ]; then
                  echo "OK"
              else
                  echo "not OK"
              fi
          else
              echo "Failed to get percentage"
          fi
          
outputs:
  mapping_result:
    type: string
    outputBinding:
      glob: stdout
      loadContents: true
      outputEval: $(self[0].contents)

stdout: stdout
