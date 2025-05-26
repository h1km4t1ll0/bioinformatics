#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "2 arguments required"
    exit 1
fi

refs="$1"
reads="$2"

echo "1. FastQC"
fastqc $reads

echo "2. Indexing reference"
minimap2 -d ref.mmi "$refs"

echo "3. Aligning reads..."
minimap2 -a ref.mmi "$reads" > aligned_reads.sam

echo "4. Running samtools flagstat..."
samtools_output=$(samtools flagstat aligned_reads.sam)
echo "${samtools_output}"

echo "5. Analyzing mapping percentage"
result=$(echo "$samtools_output" | grep -oP 'mapped \(\K[\d.]+(?=%)' | head -1)

if [ -n "$result" ]; then
    echo "Mapped ${result}%"
    if (( echo "$result > 90.0" | bc -l )); then
        echo "OK"
    else
        echo "not OK"
    fi
else
    echo "Failed to get percentage"
fi