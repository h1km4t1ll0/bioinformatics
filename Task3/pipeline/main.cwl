cwlVersion: v1.2
class: Workflow

inputs:
  refs: File
  reads: File

outputs:
  mapping_result:
    type: string
    outputSource: analyze/mapping_result

steps:
  fastqc:
    run: fastqc.cwl
    in:
      reads: reads
    out: [qc_report]

  index:
    run: index-ref.cwl
    in:
      refs: refs
    out: [mmi]

  align:
    run: align-reads.cwl
    in:
      refs_index: index/mmi
      reads: reads
    out: [samfile]

  flagstat:
    run: flagstat.cwl
    in:
      samfile: align/samfile
    out: [flagstat_out]

  analyze:
    run: analyze-mapping.cwl
    in:
      flagstat_text: flagstat/flagstat_out
    out: [mapping_result]
