#!/bin/bash

#basic range with steps for loop
for value in {10..0..2}
do
	echo $value
done

echo All done!
#DOESNT WORK!!!
#should output 10 to 0 with a step of 2 but just outputs '{10..0..2}'