#!/bin/bash

#v10 - 03/06/2014

#on declare les variables
export LC_ALL=C
export datenow=$(date +%Y%m%d)
mkdir /cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow/OK

set -x

#on execute la fonction "print_reversed" pour permettre l'inversion des fichiers

function print_reversed {     readarray -t LINES;     for (( I = ${#LINES[@]}; I; )); do         echo "${LINES[--I]}";     done; }

#fireworks: on inverse le fichier , on le duplique 3 fois pour les 3 trimestres
#

#on duplique les lignes - ok
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*tsv; do
paste -d'\n' $file $file $file> "${file%.*}v1.${file##*.}"
done


#on supprimes les premieres et deuxiemes lignes - ok
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v1.tsv; do
sed -e '1,2d' $file > "${file%.*}v2.${file##*.}"
done

#on inverse les fichiers - ok
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v2.tsv; do
print_reversed < "${file}" > "${file%.*}v3.${file##*.}"
done

#on change les Q par des ; : pourquoi cette instruction : cette instruction décale les colonnes !
#sed -i 's/Q/;/g' *v2.tsv

#on va remplacer cela par cette instruction pour supprimer les Q de la premiere colonne
#et les remplacer par un ; pour creer une deuxieme colonne - c'est ici que ça coince
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v3.tsv; do
awk -F\, '{gsub(/\Q/,"|",$1); print}' $file > "${file%.*}v4.${file##*.}"
done


#ok - on incremente la deuxieme colonne -ok
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v4.tsv; do
#awk -F\| '$1!=l{c=$2}{$2=c++}{l=$1}1' OFS=\| "${file}" > "${file%.*}v4.${file##*.}"
awk '{sub(/\|[0-9]+/,"|"c++%12+1)}1' "${file}" > "${file%.*}v5.${file##*.}"
done


#on renverse : plus long car le fichier a été dupliqué - ok
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v5.tsv; do
print_reversed < "${file}" > "${file%.*}AOK.${file##*.}"
done

#on remplace le | par un M
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*AOK.tsv; do
sed -i 's/|/M/g' $file
done

#sed -i 's/Q/M/g' *_OK.tsv

#on remplace le : par un .
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*AOK.tsv; do
sed -i 's/:/./g' $file
done

#on deplace les fichiers
mv /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v1.tsv /cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow/OK
mv /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v2.tsv /cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow/OK
mv /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v3.tsv /cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow/OK
mv /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v4.tsv /cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow/OK
mv /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*v5.tsv /cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow/OK
mv /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/*AOK.tsv /cygdrive/c/travail/etudes/projetpib/donnees/trim/$datenow/OK


#on supprime les extensions
rm /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/OK/*v1.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/OK/*v2.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/OK/*v3.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/OK/*v4.tsv
rm /cygdrive/c/travail/etudes/projetpib/donnees/trim/"$datenow"/OK/*v5.tsv

#on enleve le restant des v dans le nommage des fichiers
for file in /cygdrive/c/travail/etudes/projetpib/donnees/trim/"${datenow}"/OK/*AOK.tsv; do
    [ -e "${file}" ] || continue
    dir=${file%/*}
    filename=${file##*/}
	mv "${file}" "$(echo "${file}" | sed 's/\(.*\).............\.tsv/\1\.tsv/g')"
done
