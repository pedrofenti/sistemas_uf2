#!/bin/bash

PORT=2021
PROT_NAME="ABFP"

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

echo "(5) Listen"

HANDSHAKE=`nc -l -p 





exit 0
