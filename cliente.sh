#!/bin/bash

PORT=8080

echo "Cliente"

echo "Hola soy el cliente" | cowsay | nc localhost $PORT 
