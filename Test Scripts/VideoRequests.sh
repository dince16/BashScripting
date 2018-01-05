#!/bin/bash

# first input file is a formatted list from the manifest file and the second is the unformatted list of requests
# usage: ./segmentrequests.sh <ReportFile> <ManifestFile> <RequestsFile>

#The VIDEO variable is the representation ID for video requests as defined in the manifest file
VIDEO=4001000
ReportFile="$1".rpt
TotalVideo=0
VideoCorrect=0
VideoIncorrect=0
v=()

#Check that the script call contains the correct arguments
if [ $# -lt 3 ]; then
	echo "You did not list enough arguments"
	echo "Usage: ./segmentrequests.sh <ReportFile> <Index/ManifestFile> <RequestsFile>"
	exit 1
fi

#For each segment in the manifest file add it to an array called v.
while read -r mline;
do
	v+=($mline)
done < $2


#For each segment request, isolate the segmentID in the raw data and check if it exists in v.
while read -r line;
do
	if [[ $line == *"video"* ]]; then

			segmentID=$(awk -F"output_mobile_dash-video_eng=$VIDEO-" '{sub(/ .*/,"",$2);print $2}' <<<$line | sed 's/.dash//')
			if [[ -z "$segmentID" ]]; then
				continue
			else
				TotalVideo=$(($TotalVideo + 1))
				if [[ " ${v[@]} " =~ " ${segmentID} " ]]; then
					VideoCorrect=$(($VideoCorrect + 1))
				fi
			fi
	fi
done < $3 

#Echo all results to the report file listed as the first argument
VideoIncorrect=$(($TotalVideo-$VideoCorrect))

echo "VIDEO RESULTS" >> $ReportFile
echo >> $ReportFile
echo "Total Video Requests: $TotalVideo" >> $ReportFile
echo "Ratio of Correct/Incorrect requests: $VideoCorrect/$VideoIncorrect" >> $ReportFile
echo >> $ReportFile