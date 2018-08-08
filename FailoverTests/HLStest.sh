#/bin/bash

# $1 is the URL
# $2 is the output file name
# $3 is the request timing

#STEPS TO PROCESS
#get copy of master playlist url
#curl master playlist url
	#get first variant playlist short url
	#replace section from master with variant playlist info
#curl the variant playlist
#replace prefix and segment name
#replace base url with  master playlist url
#run command with updated variant playlist url, output name and requent timing


#Check that the script call contains the correct arguments
if [ $# -lt 3 ]; then
	echo "You did not list enough arguments"
	echo "Usage: ./HLSTest.sh <VARIANT_PLAYLIST_URL> <OUTPUT_NAME> <REQUEST_TIMING>>"
	exit 1
fi

# ** NEED TO CHANGE: master playlist url used for creating the segment url **
baseURL="http://dk-c3-poc-lb-cleveland-Virginia-747c2e2db05c346e.elb.us-east-1.amazonaws.com/cts/1.0/x/5/"

# ** NEED TO CHANGE: section of variant playlist url that denotes how many directories to go up to create the segment url **
prefix="../../../../../../"

# ** NEED TO CHANGE **
segmentName=$prefix"H09VJR-1EZFWE-YV8YIC-"

out="$2".csv
variant=""
discontinutiy=""
prev=""
dis=false

# calculates the appropriate gap of time in between the segment timestamps
correct_gap=$(curl -s $1 | grep -m 1 "#EXTINF:")
correct_gap=$(awk -F "#EXTINF:" '{sub(/ .*/,"",$2);print $2}' <<<$correct_gap | sed 's/,//')
correct_gap=$(($( printf "%.0f" $correct_gap ) * 1000))

echo Timestamp , Duration , Correct Duration , Segment Status Code >> $out

while true
do

	#removes all lines containing '#EXTINF'
	curl -s $1 | sed "/#EXTINF/d" > parsedFile

	# check if the current line contains the DISCONTINUITY tag
	if echo parsedFile | grep -q "#EXT-X-DISCONTINUITY";
		then
		echo discontinuity
	fi

	previousSegment=""
	delta=0

	while read -r line; do

		#echo $lineq

		if echo "$line" | grep -q "#EXT-X-DISCONTINUITY"; then
			dis=true

		elif echo "$line" | grep -q "#EXT"; then
			continue
		else

			currentSegment=$(awk -F $segmentName '{sub(/ .*/,"",$2);print $2}' <<<$line | sed 's/.ts//')
			echo $currentSegment",\c" >> $out

			if [[ -z "$previousSegment" ]]; then
				previousSegment=$currentSegment
				echo ",,\c" >> $out
			else
				delta="$(($currentSegment-$previousSegment))"
				echo $delta",\c" >> $out

				if [[ $delta -eq $correct_gap ]]; then
					echo "SUCCESS,\c" >> $out
				elif [[ $dis -eq true ]]; then
					echo "DISCONTINUITY,\c" >> $out
					dis=false
				else
					echo "FAIL,\c" >> $out
				fi
				previousSegment=$currentSegment
			fi

			#this prevents a hanging true in the case that the loop doesnt register a discontinuity
			if [[ $dis -eq true ]]; then
				dis=false
			fi

			segmentURL=$baseURL
			segmentURL+=$(awk -F $prefix '{sub(/ .*/,"",$2);print $2}' <<<$line)
			#echo $segmentURL
			echo $(curl -o /dev/null -s -w "%{http_code}\n" $segmentURL)"," >> $out
		fi
	done < parsedFile

	sleep $3

done
