for fic in *.csv; do
awk 'NR==1{for (i=1; i<=NF; i++) if ($i ~ /RT12-ABS-NSA,/) a[i]; 
     else printf "%s%s", $i, OFS; print ""; next}
     {for (i=1; i<=NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print "" }' $fic > "${fic%.*}v3.${fic##*.}"
; done


awk 'NR==1{for (i=1; i<=NF; i++) if ($i ~ /Gtype/) a[i]; 
     else printf "%s%s", $i, OFS; print ""; next}
     {for (i=1; i<=NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print "" }' fic
Log.NE122 Log.NE144
-0.33     1.0

awk -F";" 'NR==1{for (i=1; i<=NF; i++) if ($i ~ /Gtype/) a[i]; 
     else printf "%s%s", $i, OFS; print ""; next}
     {for (i=1; i<=NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print "" }' 


cat liste_eurostat_trim.txt | while read next; do 
mot=$(echo $next | awk '{print $1}'); 
awk -F';' '/$mot/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /$mot/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' 
done

####
#mise en place des suppressions de colonnes
####

   mv "${fic}" "$(echo "${fic}" | sed 's/\(.*\)......\.csv/\1\.csv/g')"; 

for fic in *.csv; do
awk -F';' '/RT1/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /RT1/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v1.${fic##*.}";
   mv "${fic}" "$(basename $fic .csv).old";done
   
for fic in *v1.csv; do
awk -F';' '/RT12/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /RT12/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v2.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v2.csv; do
awk -F';' '/I2005/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /I2005/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v3.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v3.csv; do
awk -F';' '/PCH_PRE/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_PRE/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v4.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v4.csv; do
awk -F';' '/PCH_SM/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_SM/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v5.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v5.csv; do
awk -F';' '/MIO_NAC_CLV2000/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /MIO_NAC_CLV2000/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v6.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v6.csv; do
awk -F';' '/RT1-ABS-SA/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /RT1-ABS-SA/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v7.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v7.csv; do
awk -F';' '/RT12-ABS-NSA/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /RT12-ABS-NSA/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v8.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v8.csv; do
awk -F';' '/RT1-IVU-NSA/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /RT1-IVU-NSA/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v9.${fic##*.}" ; 
   rm ${fic}; done
   
 for fic in *v9.csv; do
awk -F';' '/RT12-IVU-NSA/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /RT12-IVU-NSA/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v10.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v10.csv; do
awk -F';' '/RT1-IVOL-SA/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /RT1-IVOL-SA/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v11.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v11.csv; do
awk -F';' '/RT12-IVOL-NSA/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /RT12-IVOL-NSA/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v12.${fic##*.}" ; 
   rm ${fic}; done

for fic in *v12.csv; do
awk -F';' '/PCH_SAME/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_SAME/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v13.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v13.csv; do
awk -F';' '/PCH_PRE_PERS/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_PRE_PERS/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v14.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v14.csv; do
awk -F';' '/PCH_SAME_PERS/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_SAME_PERS/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v15.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v15.csv; do
awk -F';' '/MIO_EUR_CLV2000/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /MIO_EUR_CLV2000/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v16.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v16.csv; do
awk -F';' '/PCH_PRE_CPI05_NAC/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_PRE_CPI05_NAC/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v17.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v17.csv; do
awk -F';' '/PCH_PRE_CPI05_EUR/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_PRE_CPI05_EUR/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v18.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v18.csv; do
awk -F';' '/PCH_SAME_CPI05_NAC/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_SAME_CPI05_NAC/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v19.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v19.csv; do
awk -F';' '/PCH_SAME_CPI05_EUR/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /PCH_SAME_CPI05_EUR/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v20.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v20.csv; do
awk -F';' '/CPI00_NAC/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /CPI00_NAC/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v21.${fic##*.}" ; 
   rm ${fic}; done
   
for fic in *v21.csv; do
awk -F';' '/CPI00_EUR/{delete a; for (i=1; i<NF; i++) 
   if ($i ~ /CPI00_EUR/) a[i]; else printf "%s%s", $i, OFS; print $i; next} 
   {for (i=1; i<NF; i++) if (!(i in a)) printf "%s%s", $i, OFS; print $i }' OFS=';' ${fic} > "${fic%.*}v22.${fic##*.}" ; 
   rm ${fic}; done

for fic in *.csv; do   
mv "${fic}" "$(echo "${fic}" | sed 's/\(.*\).........................................................\.csv/\1\.csv/g')"; 
done

