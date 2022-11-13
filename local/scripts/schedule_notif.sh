#!/bin/sh

echo "notify-send '$1' -t 0" | at $2
