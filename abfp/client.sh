#!/bin/bash

echo "Cliente"

PORT=2021
IP_CLIENT="127.0.0.1"
IP_SERVER="127.0.0.1"
OK="OK_CONN"
KO="KO_CONN"
YES="YES_IT_IS"
OK_FILE="OK_FILE_NAME"

echo "(2) Seanding headers"

echo "ABFP $IP_CLIENT" | nc -q 1 $IP_SERVER $PORT

echo "(3) Listening"

RESPONSE=`nc -l -p $PORT`

if [ "$RESPONSE" != $OK ]; then
echo "Error: Connection refused"
exit 1
fi

echo "(6) Handshake"

sleep 1
echo "This_is_my_classroom" | nc -q 1 $IP_SERVER $PORT

echo "(7) Listening"

RESPONSE=`nc -l -p $PORT`
if [ "$RESPONSE" != $YES ]; then
echo "Error: Connection refused"
exit 2
fi

echo "(10) File name"

sleep 1
echo "File_name Magno.jpg" | nc -q 1 $IP_SERVER $PORT

echo "(11) Listening"

RESPONSE=`nc -l -p $PORT`
if [ "$RESPONSE" != $OK_FILE ]; then
echo "Error: Lost connection"
exit 3
fi

echo "(14) Data"

sleep 1 


exit 0
