#!/bin/bash

NUM=1000;
RANGE=100;
CALL=0;
dCOUNT=0;
tCOUNT=0;
M="MISS"; 
H="HIT"
div=========================================

if [ $# -gt 0 ]; then
	echo >> "$1".rpt
    echo >> "$1".trc
    echo $div$div >> "$1".rpt
    echo $div$div >> "$1".trc
	echo `date` TRACE with $2 and $3 >> "$1".trc
	echo `date` REPORT with $2 and $3 >> "$1".rpt
	echo $div$div >> "$1".rpt
    echo $div$div >> "$1".trc
    echo 
    echo Report is generating
else
	echo
    echo "Your command contains no arguments. Please enter an argument for report filename, and files to be inputted."
    echo "Usage: ./cachelists <filename> <DTV file> <DFW file>"
    echo
    exit 1
fi

while read -r mline;
do

	curl -s -D - -H "Pragma: akamai-x-cache-on" https://dtvn-vod-sponsored.akamaized.net/ss/vol2/s/AEG_CP/tfxm1020892120170401/2017-03-25-13-58-05/MFXM1020892120170401/output_mobile_dash.ism/dash/output_mobile_dash-video_eng=1201000-$mline.dash -o /dev/null > out

	while read -r line ; 
	do
		if [[ $line == "X-Cache"* ]]; then
			#echo $line;
			if [[ $line == "X-Cache: TCP_MISS"* ]]; then
				tCOUNT=$(($tCOUNT + 1));
				echo "Call with $mline DTVLive MISS">> "$1".trc
			fi
			if [[ $line == "X-Cache: TCP_HIT"* ]]; then
				echo "Call with $mline DTVLive HIT">> "$1".trc
			fi
		fi
	done < out	
done < $2

while read -r mline;
do

	curl -s -D - -H "Pragma: akamai-x-cache-on" https://dfwvod-sponsored.akamaized.net/AEG_CP/tfxm1020892120170401/2017-03-25-13-58-05/MFXM1020892120170401/output_mobile_dash.ism/dash/output_mobile_dash-video_eng=1201000-$mline.dash -o /dev/null > out

	while read -r line ; do		
		if [[ $line == "X-Cache"* ]]; then
			#echo $line;
			if [[ $line == "X-Cache: TCP_MISS"* ]]; then
				dCOUNT=$(($dCOUNT + 1));
				echo "Call with $mline: DFW MISS" >> "$1".trc
			fi
			if [[ $line == "X-Cache: TCP_HIT"* ]]; then
				echo "Call with $mline: DFW HIT" >> "$1".trc
			fi
		fi
	done < out	
done < $3

dtvlen=$(wc -l < "$2")
dfwlen=$(wc -l < "$3")

echo >> "$1".rpt
echo "DirecTV Live HIT/MISS ratio from $2: $(($dtvlen-$tCOUNT))/$tCOUNT" >> "$1".rpt
echo "DFW HIT/MISS ratio from $3: $(($dfwlen-$dCOUNT))/$dCOUNT" >> "$1".rpt
echo >> "$1".rpt
echo "DirecTV Live misses: $tCOUNT" >> "$1".rpt
echo "DFW misses: $dCOUNT" >> "$1".rpt
echo >> "$1".rpt
echo 
echo "Report and trace files can be found at $1.rpt and $1.trc."
echo
