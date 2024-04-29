#!/bin/bash

cat $1 | tr -d '\r' > __x ; mv __x $1
