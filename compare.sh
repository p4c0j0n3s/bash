tam1=$(wc -l $1 | awk '{print $1}')
tam2=$(wc -l $2 | awk '{print $1}')

echo "Size of: "$1 "=" $tam1 "lines" 
echo "Size of: "$2 "=" $tam2 "lines"   
:
if [ $tam1 -ne $tam2 ] ; then
    echo "ERROR: the files don't have the same size."
else
    i=1
    j=0
    paste $1 $2 -d ";" | 
    while read -r LINE || [ -n "$LINE" ]; do

	na=$( echo "$LINE" | cut -d ";" -f1)
	nb=$( echo "$LINE" | cut -d ";" -f2)
 
	if [ na > nb ] ; then
	    n1=$na
	    n2=$nb
	else
	    n1=$nb
	    n2=$n1
	fi

	diff=$( echo $n1 - $n2 | bc)
	tol=0.000001
#	echo "diff: "$diff" > tol: "$tol
	if [ $(echo "$diff>$tol" | bc ) -eq 1 ] ; then 
	    echo $i": NO --> " $diff
	    j=$(($j+1))
#	else
#	    echo "OK --> " $diff
	fi
	i=$(($i+1))
    done

    if [ $j -eq 0 ] ; then
	echo "*** Everything is OK. ***"
    fi
fi

