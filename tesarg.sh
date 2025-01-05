#!/bin/bash

helpFunction()
{
   echo ""
   echo "Usage: $0 -key <Youtube stream key> -file <path/to/file.mp4>"
   echo -e "\t-file path to file .mp4"
   echo -e "\t-key  YouTube stream key"
   exit 1
}

while getopts "a:b:c:" opt
do
   case "$opt" in
      file ) filevid="$OPTARG" ;;
      key ) keystr="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$filevid" ] || [ -z "$keystr" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# start script

VBR="5000k"                                    # Bitrate upstream
FPS="30"                                       # FPS to upstream
QUAL="medium"                                  # Preset quality FFMPEG
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  # URL de base RTMP youtube

SOURCE="$filevid"                              # video source
KEY="$keystr"                                  # YouTube stream key

ffmpeg \
    -stream_loop -1 -i "$SOURCE" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
    -f flv "$YOUTUBE_URL/$KEY"