#!/usr/bin/bash

# On trie le fichier par colonne , la 1ere pour les CACF et les dates

export REP=/cygdrive/d/ope_mdl

sort -t ';' -k1,1 -k4,4  $REP/filetestv2.txt > tmp && mv tmp  $REP/filetestv2.txt

# ensuite on prend les CACF ou les valeurs de la 1ere colonne qui sont en 
# doublons 

awk -F";" 'FNR==NR{a[$1]++; next} a[$1]==1' $REP/filetestv2.txt $REP/filetestv2.txt > $REP/1col.txt

awk -F";" 'FNR==NR{a[$1]++; next} a[$1]==2' $REP/filetestv2.txt $REP/filetestv2.txt > $REP/2col.csv

awk -F";" 'FNR==NR{a[$1]++; next} a[$1]==3' $REP/filetestv2.txt $REP/filetestv2.txt > $REP/3col.csv

awk -F";" 'FNR==NR{a[$1]++; next} a[$1]==4' $REP/filetestv2.txt $REP/filetestv2.txt > $REP/4col.csv

awk -F";" 'FNR==NR{a[$1]++; next} a[$1]==5' $REP/filetestv2.txt $REP/filetestv2.txt > $REP/5col.csv

awk -F";" 'FNR==NR{a[$1]++; next} a[$1]==6' $REP/filetestv2.txt $REP/filetestv2.txt > $REP/6col.csv

# pour les lignes qui contiennent des doublons sur la 1ere colonne , on les met en ligne cote a cote

awk 'NR%2{ printf $0";";next;}1' $REP/2col.csv > $REP/2col.txt

awk 'NR%3{ printf $0";";next;}1' $REP/3col.csv > $REP/3col.txt

awk 'NR%4{ printf $0";";next;}1' $REP/4col.csv > $REP/4col.txt

awk 'NR%5{ printf $0";";next;}1' $REP/5col.csv > $REP/5col.txt

awk 'NR%6{ printf $0";";next;}1' $REP/6col.csv > $REP/6col.txt

## pour le 1er fichier

awk -F';' '{print $0";"$2}' $REP/1col.txt > $REP/1colv1.txt

## pour le 2eme fichier 

paste -d';' <(cut -d';' -f 1-7  $REP/2col.txt) <(awk -F';' '{print $2}' $REP/2col.txt) <(awk -F';' '{print $11";"$9}' $REP/2col.txt) > $REP/2colv1.txt #tmp && mv tmp 2col.txt

## pour le 3eme fichier 

paste -d';' <(cut -d';' -f 1-7 $REP/3col.txt) <(awk -F';' '{print $2}' $REP/3col.txt)  <(awk -F';' '{print $11";"$9}' $REP/3col.txt) <(awk -F';' '{print $18";"$16}' $REP/3col.txt) > 3colv1.txt 

## pour le 4eme fichier 

paste -d';' <(cut -d';' -f 1-7 $REP/4col.txt) <(awk -F';' '{print $2}' $REP/4col.txt)  <(awk -F';' '{print $11";"$9}' $REP/4col.txt) <(awk -F';' '{print $18";"$16}' $REP/4col.txt) <(awk -F';' '{print $25";"$23}' $REP/4col.txt) > $REP/4colv1.txt 

## pour le 5eme fichier 

paste -d';' <(cut -d';' -f 1-7 $REP/5col.txt) <(awk -F';' '{print $2}' $REP/5col.txt)  <(awk -F';' '{print $11";"$9}' $REP/5col.txt) <(awk -F';' '{print $18";"$16}' $REP/5col.txt) <(awk -F';' '{print $25";"$23}' $REP/5col.txt) <(awk -F';' '{print $32";"$30}' $REP/5col.txt) > $REP/5colv1.txt 

 
## pour le 6eme fichier

paste -d';' <(cut -d';' -f 1-7 $REP/6col.txt) <(awk -F';' '{print $2}' $REP/6col.txt)  <(awk -F';' '{print $11";"$9}' $REP/6col.txt) <(awk -F';' '{print $18";"$16}' $REP/6col.txt) <(awk -F';' '{print $25";"$23}' $REP/6col.txt) <(awk -F';' '{print $32";"$30}' $REP/6col.txt) <(awk -F';' '{print $39";"$37}' $REP/6col.txt)> $REP/6colv1.txt 

# suppression des chaines de caractere suivants : Export CACF |Export |CACF |Sof_|_%yyyy%mm%dd%|_%yyyy%%mm%%dd%|


awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/Sof_|_%yyyy%mm%dd%|Export CACF |Export |CACF |_%yyyy%%mm%%dd%/, "", $i) } 1' $REP/1colv1.txt > $REP/1colv2.txt

awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/Sof_|_%yyyy%mm%dd%|Export CACF |Export |CACF |_%yyyy%%mm%%dd%/, "", $i) } 1' $REP/2colv1.txt > $REP/2colv2.txt

awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/Sof_|_%yyyy%mm%dd%|Export CACF |Export |CACF |_%yyyy%%mm%%dd%/, "", $i) } 1' $REP/3colv1.txt > $REP/3colv2.txt

awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/Sof_|_%yyyy%mm%dd%|Export CACF |Export |CACF |_%yyyy%%mm%%dd%/, "", $i) } 1' $REP/4colv1.txt > $REP/4colv2.txt


awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/Sof_|_%yyyy%mm%dd%|Export CACF |Export |CACF |_%yyyy%%mm%%dd%/, "", $i) } 1' $REP/5colv1.txt > $REP/5colv2.txt

awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/Sof_|_%yyyy%mm%dd%|Export CACF |Export |CACF |_%yyyy%%mm%%dd%/, "", $i) } 1' $REP/6colv1.txt > $REP/6colv2.txt

# suppression des chaines de caractere suivants : | |

awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/ /,"_", $i) } 1' $REP/1colv2.txt  > $REP/1colv3.txt
                                                                                        
awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/ /,"_", $i) } 1' $REP/2colv2.txt  > $REP/2colv3.txt
                                                                                      
awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/ /, "_", $i) } 1' $REP/3colv2.txt  > $REP/3colv3.txt
                                                                                      
awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/ /, "_", $i) } 1' $REP/4colv2.txt  > $REP/4colv3.txt
                                                                                      
awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/ /, "_", $i) } 1' $REP/5colv2.txt  > $REP/5colv3.txt
                                                                                      
awk 'BEGIN{FS=OFS=";"} {for (i=7;i<=NF;i++) gsub(/ /, "_", $i) } 1' $REP/6colv2.txt  > $REP/6colv3.txt

# manoeuvre un peu complexe : on affiche les 7 premieres col1
# ensuite on prend la 8eme colonne et on cherche le maximum de underscore et 
# ensuite on remplace les underscore par des points-virgules , en mettant des points-virgules
# supplementaires dans le cas ou la ligne ayant des _ n'a pas le nombre d'underscore 
# maximal

# on refait la meme chose pour les fichiers ayant 2 colonnes avec des infos, 3 colonnes et ainsi
# de suite 
 
# col1
paste -d';' <(awk -F';' '{print $1";"$2";"$3";"$4";"$5";"$6";"$7}' $REP/1colv3.txt) <(cut -d';' -f 8 $REP/1colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/1colv4.txt

# col2

paste -d';' <(awk -F';' '{print $1";"$2";"$3";"$4";"$5";"$6";"$7}' $REP/2colv3.txt) <(cut -d';' -f 8 $REP/2colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') >$REP/col2_p1

paste -d';' <(awk -F';' '{print $9}' $REP/2colv3.txt) <(cut -d';' -f 10 $REP/2colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') >$REP/col2_p2

paste -d';' $REP/col2_p1 $REP/col2_p2 > $REP/col2

# col3

paste -d';' <(awk -F';' '{print $1";"$2";"$3";"$4";"$5";"$6";"$7}' $REP/3colv3.txt) <(cut -d';' -f 8 $REP/3colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') >$REP/col3_p1

paste -d';' <(awk -F';' '{print $9}' $REP/3colv3.txt) <(cut -d';' -f 10 $REP/3colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') >$REP/col3_p2

paste -d';' <(awk -F';' '{print $11}' $REP/3colv3.txt) <(cut -d';' -f 12 $REP/3colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') >$REP/col3_p3

paste -d';' $REP/col3_p1 $REP/col3_p2 $REP/col3_p3 > $REP/col3


# col4

paste -d';' <(awk -F';' '{print $1";"$2";"$3";"$4";"$5";"$6";"$7}' $REP/4colv3.txt) <(cut -d';' -f 8 $REP/4colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') >$REP/col4_p1

paste -d';' <(awk -F';' '{print $9}' $REP/4colv3.txt) <(cut -d';' -f 10 $REP/4colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col4_p2

paste -d';' <(awk -F';' '{print $11}' $REP/4colv3.txt) <(cut -d';' -f 12 $REP/4colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col4_p3

paste -d';' <(awk -F';' '{print $13}' $REP/4colv3.txt) <(cut -d';' -f 14 $REP/4colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col4_p4

paste -d';' $REP/col4_p1 $REP/col4_p2 $REP/col4_p3 $REP/col4_p4 > $REP/col4

# col5

paste -d';' <(awk -F';' '{print $1";"$2";"$3";"$4";"$5";"$6";"$7}' $REP/5colv3.txt) <(cut -d';' -f 8 $REP/5colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') >$REP/col5_p1

paste -d';' <(awk -F';' '{print $9}' $REP/5colv3.txt) <(cut -d';' -f 10 $REP/5colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col5_p2

paste -d';' <(awk -F';' '{print $11}' $REP/5colv3.txt) <(cut -d';' -f 12 $REP/5colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col5_p3

paste -d';' <(awk -F';' '{print $13}' $REP/5colv3.txt) <(cut -d';' -f 14 $REP/5colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col5_p4

paste -d';' <(awk -F';' '{print $15}' $REP/5colv3.txt) <(cut -d';' -f 16 $REP/5colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col5_p5

paste -d';' $REP/col5_p1 $REP/col5_p2 $REP/col5_p3 $REP/col5_p4 $REP/col5_p5 > $REP/col5


# col6

paste -d';' <(awk -F';' '{print $1";"$2";"$3";"$4";"$5";"$6";"$7}' $REP/6colv3.txt) <(cut -d';' -f 8 $REP/6colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') >$REP/col6_p1

paste -d';' <(awk -F';' '{print $9}' $REP/6colv3.txt) <(cut -d';' -f 10 $REP/6colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col6_p2

paste -d';' <(awk -F';' '{print $11}' $REP/6colv3.txt) <(cut -d';' -f 12 $REP/6colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col6_p3

paste -d';' <(awk -F';' '{print $13}' $REP/6colv3.txt) <(cut -d';' -f 14 $REP/6colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col6_p4

paste -d';' <(awk -F';' '{print $15}' $REP/6colv3.txt) <(cut -d';' -f 16 $REP/6colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col6_p5

paste -d';' <(awk -F';' '{print $17}' $REP/6colv3.txt) <(cut -d';' -f 18 $REP/6colv3.txt | awk -F_ '{for (i=1;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}') > $REP/col6_p6

paste -d';' $REP/col6_p1 $REP/col6_p2 $REP/col6_p3 $REP/col6_p4 $REP/col6_p5 $REP/col6_p6> $REP/col6


# necessite de couper le fichier et le recomposer

#awk -F';' -vOFS=';' '{y=0;for(i=8;i<=NF;i++)y+=gsub(/[_]/,";",$i)
#                     x=x<y?y:x;NF=NF+(x-y)}NR!=FNR' 2colv3.txt{,} >  2colv4.txt
					 
#awk -F';' -vOFS=';' '{y=0;for(i=8;i<=NF;i++)y+=gsub(/[_]/,";",$i)
 #                    x=x<y?y:x;NF=NF+(x-y)}NR!=FNR' 3colv3.txt{,} >  3colv4.txt


#awk -F_ '{for (i=7;i<=NF;i++) a[NR FS i]=$i;c=NF>c?NF:c} END {for (j=1;j<=NR;j++) {for (i=1;i<c;i++) printf "%s;",a[j FS i];print a[j FS c]}}' 1colv3.txt


#awk -F';' -vOFS=';' '{(y=gsub(/[_;]/,";"))>x&&x=y;for(i=7;i<=x+1;i++)$i=""}NR!=FNR' 1colv3.txt{,}

#awk -F';' -vOFS=';' '{(y=gsub(/[_;]/,";"))>x&&x=y;for(i=NF+1;i<=x+1;i++)$i=""}NR!=FNR' 1colv3.txt{,}


#Export CACF /
#
#Export /
#
#CACF /
#
#Sof_/
#
#_%yyyy%mm%dd%
#
#_%yyyy%%mm%%dd%
#
# /
# 
#
 

 
# awk -F";" '{ for (i=7; i<=NF; i++) {$(i)=gsub(/Sof_/,"newstring", ($i) } }; print $0 ' 2colv2.txt
# 
# awk -F";" '{ for (i=7; i<=NF; i++) {$(i)=gsub(/Sof_/,"newstring", ($i) } }; print $0 ' 2colv2.txt
# 
# 
# awk -F";" '{ for (i=7; i<=NF; i++) {$(i)=gsub(/Sof_/,"newstring", ($i) } }; print $0 ' filename
# 
# index=3 
# echo "1,2,3,4" | awk -F, -v OFS=, -v INDEX=$index '{$INDEX="NEW"; print }'
# 
# 
# cut -d';' -f 11,9  2col.txt
# 
# awk '{for(i=1;i<5;i++) $i=;print}' 2col.txt
# 
# awk -F';' '{print $1-$7}' 2col.txt
# 
# cut -d';' -f 1-7  2col.txt
# 
# awk -F; '{getline f1 <"1col.txt" ;print f1,$3,$4}' OFS=; 1col1.txt
# 
# 
# paste -d';' file2 <(cut -d';' -f2- file1)
# 
# paste -d';' file2 <(cut -d';' -f4- file1)
# 
# paste -d';' file2 <(cut -d';' -f3- file1)
# 
# awk -F';' '{getline f2 <"file2" ;print f1,$3,$4}' OFS=';' file1
# 
# paste -d';' <(awk -F';' '{print $1}' file1) <(awk -F';' '{print $2}' file2) <(awk -F';' '{print $3";"$4}' file1)
# 
# A;;C;D
# A;;C;D
# A;;C;D
# A;;C;D
# 
# A;B
# A;B
# A;B
# A;B
# 

#sort Exp_janv_fev_2015.csv | awk 'NR == 1 {p=$1; next} p == $1 { print $1 " is duplicated"} {p=$1}' FS=","

#sort file | awk 'NR==FNR{a[$1]++;next;}{ if (a[$1] > 2 && a[$1] <4 )print;}' file file 

#awk 'NR == 1 {p=$1; next} p == $1 { print $1 " is duplicated"} {p=$1}' FS=";"

#awk 'NR==FNR{a[$1]++;next;}{ if (a[$1] > 1)print;}' Exp_janv_fev_2015.csv file

#<filetest.txt cut -d';' -f1 | sort -n | uniq -c

#awk '{h[$1]++}; END { for(k in h) print k, h[k] }' filetest.txt


#sort filetest.txt | 

#awk 'NR == 1 {p=$1; next} p == $1 { print $1";"$2";"$3";"$4";"$5";"$6";"$7} {p=$1}' FS=";" file > plusdeux.txt

#sort -t\;

#awk -F";" '{print $1";"$2";"$3";"$4";"$5";"$6";"$7}' filetest.txt | sort -n -r
