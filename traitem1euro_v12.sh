#!/bin/bash

#traitem1euro_v12.sh
#le fichier traite les fichiers téléchargés sur Eurostat
#se mettre dans le repertoire  /cygdrive/c/travail/etudes/projetpib/donnees

#Appelle les fichiers suivants:
#traitem1mens_actu_v2.sh
#traitem1mens_inac_v2.sh
#traitem1trim_v2.sh
#fic_trime.sh
#split_fic.sh

#
#on declare les variables

export LC_ALL=C
export datenow=$(date +%Y%m%d)

#on utilise wget pour telecharger les fichiers
wget -i "/cygdrive/c/travail/etudes/projetpib/programmes/liste_eurostat_tsv_v2.txt" -o telecharge.log -P /cygdrive/c/travail/etudes/projetpib/donnees

#dezippe les fichiers

for file in /cygdrive/c/travail/etudes/projetpib/donnees/*.gz; do
dir=${file%/*}
gunzip  "$file"
done

#tronque les fichiers de leurs premiers 85 caractères

for file in /cygdrive/c/travail/etudes/projetpib/donnees/*tsv; do 
dir=${file%/*}
mv $file "$dir/`echo $file | cut -c85-`"; done

#creation des répertoires pour le mois

mkdir "/cygdrive/c/travail/etudes/projetpib/donnees/mens_actu/${datenow}" "/cygdrive/c/travail/etudes/projetpib/donnees/mens_inac/${datenow}" "/cygdrive/c/travail/etudes/projetpib/donnees/trim/${datenow}" "/cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}" "/cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/dico"

#execution des fichiers pour déplacer les fichiers dans leur répertoire respectif

"/cygdrive/c/travail/etudes/projetpib/programmes/traitem1mens_actu_v2.sh"
"/cygdrive/c/travail/etudes/projetpib/programmes/traitem1mens_inac_v2.sh"
"/cygdrive/c/travail/etudes/projetpib/programmes/traitem1trim_v2.sh"

#on supprime les lettres suivantes : bcdefinprsuz

for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*.tsv; do
	[ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
    sed -i '2,$s|[bcdefinprsuz]||g' $file
done

#on supprime le 0n
for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*.tsv; do
	[ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
    sed -i '2,$s/0n//g' $file
done



#On transpose les fichiers avec le fichier trans.sh

for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*.tsv; do
    [ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
    "/cygdrive/c/travail/etudes/projetpib/programmes/trans.sh" < "${file}" > "${dir}/${filename%.*}v1.${file##*.}"
done

#On transforme les espaces en point virgule

for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*v1.tsv; do
    [ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
    sed -e "s/ /;/g" "${file}" > "${file%.*}v2.${file##*.}"
done

#On transforme la chaine de caractère de la premiere occurence sur la première ligne
#pour mettre le mot date
for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*v2.tsv; do
    [ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
	awk 'BEGIN{FS=OFS=";"}  NR==1 {$1="DATE"} 1' "${file}" > "${file%.*}v3.${file##*.}" 
done


#On suprime le v1v2v3 des noms de fichiers

for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*v1v2v3.tsv; do
    [ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
	mv "${file}" "$(echo "${file}" | sed 's/\(.*\)......\.tsv/\1\.tsv/g')"
done

#on transforme le : en .
for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*.tsv; do
    [ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
	sed -i 's/:/./g' "${file}"
done

#on rajoute une etape supplementaire

#on transforme les M0 en M
for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*.tsv; do
    [ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
	sed -i 's/M0/M/g' "${file}"
done

#On supprime les fichiers de transition

rm /cygdrive/c/travail/etudes/projetpib/donnees/mens_actu/"$datenow"/*v2.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/mens_actu/"$datenow"/*v1.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/mens_inac/"$datenow"/*v2.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/mens_inac/"$datenow"/*v1.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v2.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v1.tsv


#copie du script
cp "/cygdrive/c/travail/etudes/projetpib/donnees/trim/fic_trime.sh" "/cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow"

#Execution du script ou on ajoute des lignes pour avoir des mois
#par rapport a ces fichiers qui sont trimestriels
"/cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow/fic_trime.sh"


#On renomme les fichiers  mais en conservant leurs correspondances

i=1

for file in /cygdrive/c/travail/etudes/projetpib/donnees/mens_actu/"${datenow}"/*.tsv; do
    [ -e "${file}" ] || continue
	dir=${file%/*}
	cp "${file}" "${file%.*}v$i.${file##*.}"
	mv "$file" "$dir/fic${i}.csv"
	((i++))
done 

for file in /cygdrive/c/travail/etudes/projetpib/donnees/mens_inac/"${datenow}"/*.tsv; do
    [ -e "${file}" ] || continue
	dir=${file%/*}
	cp "${file}" "${file%.*}v$i.${file##*.}"
	mv "$file" "$dir/fic${i}.csv"
	((i++))
done 

for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"${datenow}"/OK/*.tsv; do
    [ -e "${file}" ] || continue
	dir=${file%/*}
	cp "${file}" "${file%.*}v$i.${file##*.}"
	mv "$file" "$dir/fic${i}.csv"
	((i++))
done 

#On déplace les fichiers dans le pot commun

for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/*.csv; do
	mv "${file}" "/cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}"
done

for file in /cygdrive/c/travail/etudes/projetpib/donnees/*/"${datenow}"/OK/*.csv; do
	mv "${file}" "/cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}"
done


#on supprime le fichier comportant des chaines comme M11M12

for fic in /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/*csv; do 
	if [[ -n $(grep 'M11M12' $fic) ]]; then 
	mv $fic  "$(basename $fic .csv).MISC"; 
	fi ; 
done


#
#derniere partie: split des fichiers
# tout fichier faisant plus de 4000
# colonnes sera scindée en plusieurs morceaux 


"/cygdrive/c/travail/etudes/projetpib/programmes/split_fic.sh"

#une fois, on supprime les fichiers originaux qui on plus de 5000 colonnes
#suppression des fichiers qui ont plus de 5000 colonnes
lim=4005

for fic in /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/*.csv; do 
col=$(awk 'NR==1{print NF}' OFS=\; FS=\; $fic) ; 
	if [[ $col -gt $lim ]]; 
		then 
			mv $fic  "/cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/$(basename $fic .csv).BIG"; 
	fi ; 
done

#changement des noms de fic avec nouvelle numerotation

#pour voir si on a des doublons

for file in /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/*.csv; 
do awk 'a[$0]++{exit 1}' $file || mv $file "/cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/$(basename $fic .csv).2blon"; done

#renommage des fichiers

i=1
for file in /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/*.csv; do
    [ -e "${file}" ] || continue
	dir=${file%/*}
	mv "$file" "$dir/fich${i}.csv"
	((i++))
done 
	
# rm fich88.csv
# 
# i=1
# for file in /cygdrive/c/travail/etudes/projetpib/donnees/fichiersfinaux/${datenow}/*.csv; do
#     [ -e "${file}" ] || continue
# 	dir=${file%/*}
# 	mv "$file" "$dir/fich${i}.csv"
# 	((i++))
# done 