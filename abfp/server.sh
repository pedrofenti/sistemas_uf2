#!/bin/bash

PORT=2021
PROT_NAME="ABFP"
HANDSHAKE="This_is_my_classroom"


echo "(0) Alejandro's Big Fucking Protocol"

echo "(1) Listening $PORT"

HEADER=`nc -l -p $PORT`
PREFIX=`echo $HEADER | cut -d " " -f 1`
IP_CLIENT=`echo $HEADER | cut -d " " -f 2`

echo "TEST HEADER"

echo "(4) Response"

if [ $PREFIX != $PROT_NAME ]; then 
echo "Error: Wrong header"
sleep 1
echo "KO_CONN" | nc -q 1 $IP_CLIENT $PORT
exit 1
fi

sleep 1
echo "OK_CONN" | nc -q 1 $IP_CLIENT $PORT

echo "(5) Listening"

CLIENT_HANDSHAKE=`nc -l -p $PORT`

echo "(8) Response"

if [ $CLIENT_HANDSHAKE != $HANDSHAKE ]; then
echo "Error: Wrong handshake"
sleep 1
echo "KO_HANDSHAKE" | nc -q 1 $IP_CLIENT $PORT
exit 2 
fi

sleep 1
echo "YES_IT_IS" | nc -q 1 $IP_CLIENT $PORT

echo "(9) Listening"

FILE_NAME=`nc -l -p $PORT`

echo "(12) Response"

sleep 1
echo "OK_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT

echo "(13) Listening"

CLIENT_DATA=`nc -l -p $PORT`

echo "(16) Response"


exit 0
