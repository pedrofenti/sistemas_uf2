#!/bin/bash

PORT=2021
PROT_NAME="ABFP"
HANDSHAKE="THIS_IS_MY_CLASSROOM"


echo "(0) Alejandro's Big Fucking Protocol"

echo "(1) Listening $PORT"

HEADER=`nc -l -p $PORT`
PREFIX=`echo $HEADER | cut -d " " -f 1`
IP_CLIENT=`echo $HEADER | cut -d " " -f 2`

echo "TEST HEADER"

echo "(4) Response"

if [ "$PREFIX" != $PROT_NAME ]; then 
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

if [ "$CLIENT_HANDSHAKE" != $HANDSHAKE ]; then
echo "Error: Wrong handshake"
sleep 1
echo "KO_HANDSHAKE" | nc -q 1 $IP_CLIENT $PORT
exit 2 
fi

sleep 1
echo "YES_IT_IS" | nc -q 1 $IP_CLIENT $PORT

echo "(9) Listening"

FILE_NAME=`nc -l -p $PORT`
PREFIX=`echo $FILE_NAME | cut -d " " -f 1`
NAME=`echo $FILE_NAME | cut -d " " -f 2`
MD5_NAME=`echo $FILE_NAME | cut -d " " -f 3`

echo "(12) Response"

if [ "$PREFIX" != "FILE_NAME" ]; then 
echo "Error: worng prefix"
sleep 1
echo "KO_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT
exit 3
fi

MD5_CHECK=`echo $NAME | md5sum | cut -d " " -f 1`

if [ "$MD5_CHECK" != "$MD5_NAME" ]; then 
echo "Error: worng file name"
sleep 1
echo "KO_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT
exit 4
fi

sleep 1
echo "OK_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT

echo "(13) Listening"

nc -l -p $PORT > archivo_entrada.vaca
cat archivo_entrada.vaca
echo "(16) Response"


exit 0
