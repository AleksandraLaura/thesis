#!/bin/bash

# read the file with the names into an array
mapfile -t names < euksim_adptSim.txt

for name in "${names[@]}"
do
    # get the base name without the directory and extension
    base=$(basename "$name" .txt)

    # modify the fasta file
    sed "s/^>/>${base}:/g" "adptSim-${base}.fasta" > "adptSim-${base}.modified.fasta"
done

