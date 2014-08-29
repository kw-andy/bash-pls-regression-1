#!/bin/bash

#calend_v1.sh
#v1: 240714

export LC_ALL=C
export datenow=$(date +%Y%m%d)

mkdir "/cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow"

set -x


#on utilise wget pour telecharger les fichiers
wget -i "/cygdrive/c/travail/etudes/projetpib/programmes/liste_calend_v1.txt" -o telecharge.log -P /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow

for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/Node*; do
dir=${file%/*}
    mv "$file" "$dir/`basename $file `.txt"
done

for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/*.txt; do 
dir=${file%/*}
mv $file "$dir/`echo $file | cut -c94-`"; done

for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/*.txt; do 
sed -i '1,6d' $file;
done
 
for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/*.txt; do 
  cut -c187- $file > "${file%.*}v1.${file##*.}" ;
done

for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/*v1.txt; do 
 sed -i '2,$d' $file;
done

# plus on diminue, plus la colonne se rétrécit

for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/*v1.txt; do 
 cut -c1-270 $file > "${file%.*}v2.${file##*.}" ;
done

# for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/*v1.txt; do 
#  cut -c1-240 $file > "${file%.*}v2.${file##*.}" ;
# done

#for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/*v1.txt; do 
# cut -c1-245 $file > "${file%.*}v2.${file##*.}" ;
#done

for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/*v2.txt; do 
 sed -i 's/\<class\>//g' $file;
 sed -i 's/\<text\>//g' $file;
 sed -i 's/\<nbsp\>//g' $file;
 sed -i 's/\<tr\>//g' $file;
 sed -i 's/\<td\>//g' $file;
 sed -i 's/\<colspan\>//g' $file;
 sed -i 's/\<textBold\>//g' $file;
 sed -i 's/\<tex\>//g' $file;
 sed -i 's/\<Code\>//g' $file;
 sed -i '$s|[<>/&;"=:]||g' $file;
 sed -i 's/\<extBold\>//g' $file;
 sed -i 's/\<old\>//g' $file;
 sed -i 's/\<ode\>//g' $file;
 sed -i 's/\<Bold\>//g' $file;  
 sed -i 's/\<tBold\>//g' $file;  
 sed -i 's/\<xtBold\>//g' $file;  
 sed -i 's/\<ld\>//g' $file;
 sed -i 's/\<lass\>//g' $file; 
 sed -i 's/\<100\>//g' $file; 
 sed -i '$s|[)]||g' $file;
 sed -i 's/\<d\>//g' $file; 
 sed -i 's/\<e\>//g' $file; 
 sed -i 's/\<s\>//g' $file; 
 sed -i 's/\<r\>//g' $file; 
 sed -i 's/\<ss\>//g' $file;
 sed -i 's/\<de\>//g' $file;
 sed -i 's/\<es\>//g' $file;
done; 

#sed -i 's/\<10\>//g' $file; 

for file in /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/*v2.txt; do
dir=${file%/*}
paste -d'\n' $file >> "$dir/bigfile.txt"
done

awk -F'[[:space:]]+[[:digit:]]+ Last update of data[[:space:]]+' '{
    sub(/.*[[:space:]]/,"",$1)
    sub(/[[:space:]].*$/,"",$2)
    printf "%-20s%10s\n", $1, $2
}' /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/bigfile.txt > /cygdrive/c/travail/etudes/projetpib/donnees/calend/$datenow/bigfilev2.csv

