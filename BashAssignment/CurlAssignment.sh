while read line || [[ -n $line ]]; 
do

	curl -sLw "%{url_effective} - %{http_code}\\n" $line -o /dev/null >> statusCodes.txt

done <URLs.txt