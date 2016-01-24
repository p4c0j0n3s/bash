i=1
paste f1 f2 -d ";" | 
while read -r LINE || [ -n "$LINE" ]; do

    n1=$( echo "$LINE" | cut -d ";" -f1)
    n2=$( echo "$LINE" | cut -d ";" -f2)

    diff=$( echo $n1 - $n2 | bc)

    c=0.001
    if [ $(echo "$diff>$c" | bc ) -eq 1 ] ; then 
    	echo $i": NO --> " $diff
    elif [ $(echo "$diff<$c" | bc) -eq 1 ]; then
        echo $i": NO --> " $diff
    else
  	echo "SI --> " $diff
    fi
    i=$(($i+1))
done
