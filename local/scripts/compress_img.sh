#!/bin/bash
convert $1 -strip -gaussian-blur 0.05 -quality 50% $2

