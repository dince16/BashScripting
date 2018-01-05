#!/bin/bash/

#basic until loop
counter=1
until [ $counter -gt 10 ]
do 
	echo $counter
	((counter++))
done

echo All done!
#the point of having two very similar loops is to help increase
#readabity of code (use the loop that makes the most sense in context)