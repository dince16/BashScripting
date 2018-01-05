## VideoRequests.sh

#### Overview

Runs through a list of raw segment requests taken directly from Chrome DevTools window and calculates how many video segment requests matched segments from the ManifestFile argument.  ManifestFile contains a formatted list of calculated segments from the original manifest file.

As is, the script is only equipped to recognize and test *video segments* but could be modified to test for other types of segments as well.

#### Terminology

A **raw segment request** refers to the output from Chrome DevTools window which looks like this:

```
output_mobile_dash-video_eng=4001000-$TimeStamp.dash
```
Where `$TimeStamp` is the information used to validate the request in the script.

#### How to Run

Create a directory that contains *VideoRequests.sh* as well as its ManifestFile and RequestsFile arguments.  The first argument in the call is the name of the output file that it will write to.  The second is a formatted list of segment timstamps from the manifest file.  The last argument is a list of raw segment requests.  
Usage: sh VideoRequests.sh <ReportFile> <ManifestFile> <RequestsFile>

#### Interpreting Results

The script outputs a `.rpt` file with the name of the first argument in the call.  This file will have the total number of video segment calls, the number correct and the number incorrect for the list of requests.  If called multiple times, the script will append output to the same file as long as the same name is specified as an argument in the subsequent calls.


Below is an example of an output file for four different request files tested:

```

VIDEO RESULTS

Total Video Requests: 65
Ratio of Correct/Incorrect requests: 65/0

VIDEO RESULTS

Total Video Requests: 70
Ratio of Correct/Incorrect requests: 70/0

VIDEO RESULTS

Total Video Requests: 76
Ratio of Correct/Incorrect requests: 76/0

VIDEO RESULTS

Total Video Requests: 115
Ratio of Correct/Incorrect requests: 115/0

```
