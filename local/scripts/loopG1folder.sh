#!/bin/bash

while :
do

    DIR="/mnt/hdd/data/videos/gameone-clips/"
    VIDEO=$(ls ${DIR}| grep .mkv | shuf -n 1)
    nohup bgVideoWithSound.sh -w 1920 -h 1080 -v "/mnt/hdd/data/videos/gameone-clips/${VIDEO}" > /dev/null &> /dev/null &

    echo "Waiting for video to finish"

    date

    wait

    date

    echo "Done, time for the next video"
done
