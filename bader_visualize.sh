#copy POSCAR and POTCAR into the folder
#open vith ase-gui and save POSCAR for cartesian

touch poscar.vtf
rm poscar.vtf

sed -n '/--------------------------------------------------------------------------------/,/--------------------------------------------------------------------------------/{/--------------------------------------------------------------------------------/b;/--------------------------------------------------------------------------------/b;p}' ACF.dat | awk '{print "atom "$1-1 " beta "$5}' > poscar.vtf

totelt=`awk -F' ' '{print NF; exit}' POSCAR`
elts=`awk 'NR==1{print}' POSCAR `
eltsarray=(`echo $elts`)
eltsnum=`awk 'NR==6{print}' POSCAR `
eltsnumarray=(`echo $eltsnum`)

#debug
echo "$totelt $elts ${eltsarray[0]} $eltsnum ${eltsnumarray[0]}"
#debug

for((i=0;i<totelt;i++))
do
eltsvalencearray[$i]=`sed -n '/  PAW_PBE '"${eltsarray[$i]} "'/{n;p;}' POTCAR`
done

#debug
echo "${eltsvalencearray[0]}"
echo "${eltsvalencearray[1]}"
echo "${eltsvalencearray[2]}"
#debug


start=0
for((i=0;i<$totelt;i++))
do
end=`echo "$start - 1 + ${eltsnumarray[$i]}" | bc -l`
echo "$start  $end"
if [ $start -eq $end ]
then
sed -n '/atom '"$start"' beta */p' poscar.vtf > ${eltsarray[$i]}
else 
sed -n '/atom '"$start"' beta */,/atom '"$end"' beta */p' poscar.vtf > ${eltsarray[$i]} 
fi
start=`echo "$start + ${eltsnumarray[$i]}" | bc -l`
done

rm poscar.vtf

for((i=0;i<totelt;i++))
do
awk -v val="${eltsvalencearray[$i]}" -v eltname="${eltsarray[$i]}" '{print $1" "$2" "$3" "val-$4" name "eltname }' ${eltsarray[$i]} >> poscar.vtf 
done

awk '{print $4}' poscar.vtf > CHG
minmax.sh CHG
rm CHG


echo " " >> poscar.vtf
echo "timestep" >> poscar.vtf
sed -e '1,/Cartesian/ d' POSCAR | awk '{print $1 " "$2" "$3}' >> poscar.vtf
