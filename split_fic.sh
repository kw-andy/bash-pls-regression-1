#!/bin/bash

#on declare les variables
export LC_ALL=C
export datenow=$(date +%Y%m%d)
#export datenow=20140616
#version finale (peut-être)

set -x

lim=4000

for fic in /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/*.csv; do 
ncol=$(awk 'NR==1{print NF}' OFS=\; FS=\; "$fic"); 
	if [[ ${ncol} -gt ${lim} ]]; 
	then 
		for (( i=0, start=1, end=${lim}; i < ncol/lim + 1; i++, start+=lim, end+=lim )); 
			do cut -d';' -f$start-$end "$fic" > "${fic%.*}v$i.${fic##*.}"; 
			if [[ $i -ge 1 ]];
			then 
				cut -d';' -f$start-$end "$fic" > "${fic%.*}t$i.${fic##*.}"; 
				awk '{print $1}' OFS=\; FS=\; "${fic%.*}v0.${fic##*.}" > "${fic%.*}txt.${fic##*.}";
				sed -i 's/$/;/' "${fic%.*}txt.${fic##*.}";
				paste "${fic%.*}txt.${fic##*.}" "${fic%.*}t$i.${fic##*.}" > "${fic%.*}v$i.${fic##*.}"
				rm /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/*txt.csv
				rm /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/*t$i.csv
			fi
		done ; 
	fi;
done

#XIFS="${IFS}"
#IFS=$';'
#while read -a LINE; do 
#  for (( i=0; i< ${#LINE[@]}; i++ )); do
#    echo "${LINE[$i]}" >> ${PWD}/fic${i}
#  done
#done < fic35.csv
#IFS="${XIFS}"
#
#infile="fic35.csv"
#
#inc=6000
#
#(($# == 2)) || { echo -e "\nUsage: $0 <file to split> <# columns in each split>\n\n"; exit; }
#
#
#ncol=$(awk 'NR==1{print NF}' OFS=\; FS=\; "$infile")
#
##awk 'NR==1{print NF}' OFS=\; FS=\; 
#
#((inc < ncol)) || { echo -e "\nSplit size >= number of columns\n\n"; exit; }
#
#for fic in *.csv; do 
#ncol=$(awk 'NR==1{print NF}' OFS=\; FS=\; "$fic")
#if [[ $ncol > $inc ]]; then
#for((i=0, start=1, end=$inc; i < ncol/inc + 1; i++, start+=inc, end+=inc)); do
#  cut -d';' -f$start-$end "$infile" > "${infile}.$i";
#done 
#; done 
#
#
#for fic in *.csv; do 
#ncol=$(awk 'NR==1{print NF}' OFS=\; FS=\; "$fic")
#if [[ ${ncol} > ${inc} ]]; then
#	for((i=0, start=1, end=$inc; i < ncol/inc + 1; i++, start+=inc, end+=inc)); do
#		cut -d';' -f$start-$end "$fic" > "${fic%.*}$i.${fic##*.}";
#	done 
#fi
#;done
#
#cat ttfilm.txt | while read next; 
#do i=$(echo $next | awk '{print $1}'); k=$(echo $next | awk '{print $2}'); wget "http://www.allocine.fr/video/player_gen_cmedia=$i&cfilm=$k.html" -O index.html$j; ((j++)); done
#
# 
#
#for fic in *.csv;
#do 
#ncol=$(awk 'NR==1{print NF}' OFS=\; FS=\; "$fic")
#if (( ${ncol} > ${inc} ))
#	then
#		for((i=0, start=1, end=$inc; i < ncol/inc + 1; i++, start+=inc, end+=inc)); do
#			cut -d';' -f$start-$end "$fic" > "${fic%.*}v$i.${fic##*.}";
#		done 
#fi
#;done
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#