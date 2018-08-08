#### HLSTest.sh

## Synopsis

```
./HLSTest.sh <VARIANT_PLAYLIST_URL> <OUTPUT_NAME> <REQUEST_TIMING>
```

`VARIANT_PLAYLIST_URL`: The URL of the variant list that is generated form its master playlist url.  The **Master Playlist URL** is generated from the DK UI for the specified streaming window parameters.

`OUTPUT_NAME`: The name specifying the output.  The script generates a .csv that will be described more in a later section.  **DO NOT INCLUDE AN EXTENSION WITH THIS PARAMETER**

`REQUEST_TIMING`: The number of seconds the script needs to wait before curl the given url again. This parameter should be a **single integer**.

## Description

This script is used to continuously curl a **Variant Playlist URL** that gets generated from a **Master Playlist URL** found on the Digital Keystone UI.  The script `curls` the given URL, parses out unnecessary output from the curl statement and processes each line of the curl output.  Each line contains the short URL of a **Segment**.  

The purpose of this script is to parse out the timestamp found in each **Segment** URL, calculate the delta between that **Segment** and the previous, determine if the delta is appropriate based on the specifications of the document, and then curl the full **Segment** URL to ensure that the segment exists.  This script also checks for `DISCONTINUITY` tags which specify when the delta between two **Segment** timestamps does not match the specified appropriate delta from the **Variant Playlist** document.

## Steps to Process

1. Get copy of **Master Playlist URL**.
2. Curl the **Master Playlist URL**.
```
curl http://dk-c3-poc-lb-001-fb272976759caab4.elb.us-east-1.amazonaws.com/cts/1.0/x/5/__start/1531312800000/__stop/1531313100000/83H3KM.m3u8
```
3. From the output of the curl command, select one **Variant Playlist URL**
4. Replace the last part of the **Master Playlist URL** with the last part of the **Variant Playlist URL** beginning from the `/__start/` section of the url and curl that as well
```
curl http://dk-c3-poc-lb-001-fb272976759caab4.elb.us-east-1.amazonaws.com/cts/1.0/x/5/__start/1532520900000/__stop/1532522700000/__ext/1532535100917-1800000/H09VJR-1LIOQA-83H3KM.m3u8
```
4. In the script you will see a section of variables that need to be updated for the specific URLs you are using.
```
# ** NEED TO CHANGE: master playlist url used for creating the segment url **
baseURL="http://dk-c3-poc-lb-cleveland-Virginia-747c2e2db05c346e.elb.us-east-1.amazonaws.com/cts/1.0/x/5/"

# ** NEED TO CHANGE: section of variant playlist url that denotes how many directories to go up to create the segment url **
prefix="../../../../../../"

# ** NEED TO CHANGE **
segmentName=$prefix"H09VJR-1EZFWE-YV8YIC-"
```
`baseURL`: the beginning part of the **Master Playlist URL** that will be used to construct the **Segment URLs**.

`prefix`: the beginning part of each **Segment Short URL**.  This variable shouldn't have to change for each different URL but double check the prefix from your curl output.

`segmentName`: the name of the **Segments*** from your **Variant Playlist URL** should be the same for each **Segment**. It should also have the same format as the one shown above (three, 6 character sections divided by dashes).  **Make sure to include the trailing `-`**.

## Output

This script is primarily testing for three things, each of which is detailed in the output of the script. The script is testing for:

1. Correct Duration
2. Segment URLs that exist and can be accessed
3. Discontinuity

Example output:
```
Timestamp , Duration , Correct Duration , Segment Status Code
1532647806879,,,200,
1532647814879,8000,SUCCESS,200,
1532647822879,8000,SUCCESS,200,
1532647830879,8000,SUCCESS,200,
1532647838879,8000,SUCCESS,200,
1532647846879,8000,SUCCESS,200,
1532647854879,8000,SUCCESS,200,
1532647862879,8000,SUCCESS,200,
1532647870879,8000,SUCCESS,200,
1532647878879,8000,SUCCESS,200,
1532647886879,8000,SUCCESS,200,
1532647894879,8000,SUCCESS,200,
1532647902879,8000,SUCCESS,200,
1532647910879,8000,SUCCESS,200,
1532647918879,8000,SUCCESS,200,
```

`Timestamp`: this column lists the timestamp of each **Segment** in the **Variant Playlist** document.

`Duration`: this column measures the delta between the current **Segment** and the previous.  The *first **Segment*** of each run will have a blank spot in this column because there is no previous segment.

`Correct Duration`: this column will either list `SUCCESS`, `FAIL`, or `DISCONTINUITY` depending on how the duration for that segment compares to the appropriate segment delta. The *first **Segment*** of each run will have a blank spot in this column because there is no previous segment.

`Segment Status Code`: this column shows the status code of a curl statement to each constructed segment URL.
