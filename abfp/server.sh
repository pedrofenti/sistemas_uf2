#!/bin/bash

echo "Server"

PORT=2021

PROT_NAME="ABFP"
HANDSHAKE="THIS_IS_MY_CLASSROOM"
OUTPUT_PATH="salida_server/"


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

echo "(9.a) Listen num files"

NUM_FILES=`nc -l -p $PORT`
PREFIX=`echo $NUM_FILES | cut -d " " -f 1`
NUM=`echo $NUM_FILES | cut -d " " -f 2`

if [ "$PREFIX" != "NUM_FILES" ]; then
	echo "ERROR: Prefijo NUM_FILES incorrecto"

	sleep 1
	echo "KO_NUM_FILES" | nc -q 1 $IP_CLIENT $PORT
	exit 3
fi

sleep 1
echo "OK_NUM_FILES" | nc -q 1 $IP_CLIENT $PORT

echo "NUM FILES: $NUM"

for NUMBER in `seq $NUM`; do 

	echo "(9.b) Listening names"

	FILE_NAME=`nc -l -p $PORT`
	PREFIX=`echo $FILE_NAME | cut -d " " -f 1`
	NAME=`echo $FILE_NAME | cut -d " " -f 2`
	MD5_NAME=`echo $FILE_NAME | cut -d " " -f 3`

	echo "(12) Response"

	if [ "$PREFIX" != "FILE_NAME" ]; then 
		echo "Error: worng prefix"
		sleep 1
		echo "KO_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT
		exit 4
	fi

	MD5_CHECK=`echo $NAME | md5sum | cut -d " " -f 1`

	if [ "$MD5_CHECK" != "$MD5_NAME" ]; then 
		echo "Error: worng file name"
		sleep 1
		echo "KO_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT
		exit 5
	fi

	sleep 1
	echo "OK_FILE_NAME" | nc -q 1 $IP_CLIENT $PORT

#	echo "(12.b) mail"
#	echo "$NAME" | mail -s "Nombre del archivo recibido" alejandro_test@mailinator.com

	echo "(13) Listening"

	nc -l -p $PORT > $OUTPUT_PATH$NAME

done

echo "(16) Response"

sleep 1
echo "OK_DATA" | nc -q 1 $IP_CLIENT $PORT


echo "(17) Listening"

GOODBYE=`nc -l -p $PORT`

if [ "$GOODBYE" != "ABFP GOOD_BYE" ]; then
	echo "Error: wrong goodbye"
	exit 6
fi

exit 0
