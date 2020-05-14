awk '{for(x=1;x<=NF;x++)a[++y]=$x}END{c=asort(a);print "min:",a[1];print "max:",a[c]}' $1
awk '{for(x=1;x<=NF;x++) i+=$1}END{print "sum:",i}' $1
