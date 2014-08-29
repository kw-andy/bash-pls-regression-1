#!/bin/bash

#on declare les variables
i=1
for file in /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/20140422/*.csv; do
    [ -e "${file}" ] || continue
	dir=${file%/*}
	mv "$file" "$dir/fich${i}.csv"
	((i++))
done 
	