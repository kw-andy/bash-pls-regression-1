#!/usr/bin/bash 

export LC_ALL=fr_FR.UTF-8


set -x

REP=/cygdrive/d/ope_mdl/sofinco

sed -i 's/vif=//g' $REP/fichier_texte.txt

sed -i 's/\[//g' $REP/fichier_texte.txt

sed -i 's/\]//g' $REP/fichier_texte.txt

sed -i 's/ /;/g' $REP/fichier_texte.txt



cat << EOF > $REP/list.txt
fck=35 fmd
fck=78 fmd
EOF

perl $REP/parser.pl $REP/list.txt $REP/fichier_texte.txt > $REP/Fic_35_78.txt

echo "fck=84 fcv" > $REP/list.txt

perl $REP/parser.pl $REP/list.txt $REP/fichier_texte.txt > $REP/Fic_84.txt

echo "fck=85 fcv" > $REP/list.txt

perl $REP/parser.pl $REP/list.txt $REP/fichier_texte.txt > $REP/Fic_85.txt

echo "fck=86 fcv" > $REP/list.txt

perl $REP/parser.pl $REP/list.txt $REP/fichier_texte.txt > $REP/Fic_86.txt

echo "fck=83 fcv" > $REP/list.txt

perl $REP/parser.pl $REP/list.txt $REP/fichier_texte.txt > $REP/Fic_83_fcv.txt

echo "fck=83 fmd" > $REP/list.txt

#
# execution du script perl
#

perl $REP/parser.pl $REP/list.txt $REP/fichier_texte.txt > $REP/Fic_83_fmd.txt

paste -d"|" $REP/fic_83_fcv.txt $REP/fic_83_fmd.txt > $REP/83_fcv_fmd.txt

sed -i 's/|//g' $REP/83_fcv_fmd.txt 

#
# execution du script python
#

python3 $REP/parser1.py < $REP/83_fcv_fmd.txt > $REP/83_v1_fcv_fmd.txt

paste -d"|"  $REP/Fic_35_78.txt $REP/Fic_84.txt $REP/Fic_85.txt $REP/Fic_86.txt $REP/83_v1_fcv_fmd.txt > $REP/Fic_coller.txt

sed -i 's/|//g' $REP/Fic_coller.txt

cut -d";" -f 1 $REP/fichier_texte.txt > $REP/Pk_col.txt

paste -d";" $REP/Pk_col.txt $REP/Fic_coller.txt > $REP/Fic_entier.txt

cut --delimiter=';' --fields=2,4,6,8,10,12,13,14,15,16,17,18,19,20,21,22,23 --complement $REP/Fic_entier.txt > $REP/Fic_v1_entier.txt

sed -i 's/,//g' $REP/Fic_v1_entier.txt

sed -i 's/pk=//g' $REP/Fic_v1_entier.txt

sed -i 's/fcv=//g' $REP/Fic_v1_entier.txt

sed -i 's/fmd=//g' $REP/Fic_v1_entier.txt

### changement par %Y/%m/%d par %d/%m/%Y

awk -F\; ' {OFS=";"}  { $2 = strftime("%d/%m/%Y",$2)} { $3 = strftime("%d/%m/%Y",$3)} { $7 = strftime("%d/%m/%Y",$7)} { $8 = strftime("%d/%m/%Y",$8)} { $9 = strftime("%d/%m/%Y",$9)} { $10 = strftime("%d/%m/%Y",$10)} { $11 = strftime("%d/%m/%Y",$11)} { $12 = strftime("%d/%m/%Y",$12)} { $13 = strftime("%d/%m/%Y",$13)} { $14 = strftime("%d/%m/%Y",$14)} { $15 = strftime("%d/%m/%Y",$15)} { $16 = strftime("%d/%m/%Y",$16)}1' $REP/Fic_v1_entier.txt > $REP/fic_v2_entier.txt

sed -i 's/01\/01\/1970//g' $REP/fic_v2_entier.txt

sed -i 's/true/vrai/g' $REP/fic_v2_entier.txt

sed -i 's/false/faux/g' $REP/fic_v2_entier.txt
