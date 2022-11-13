#!/bin/bash

FILE=$(ls /proc/$(pidof awesome)/fd/2)
tail -f $FILE;

