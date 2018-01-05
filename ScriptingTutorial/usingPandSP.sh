#!/bin/bash/

#understanding -p and -sp
read -p 'Username: ' userVar
read -sp 'Password: ' passVar

echo
echo Thank you $userVar we now have your login details

echo Password: $passVar