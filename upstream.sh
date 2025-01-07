#!/bin/bash
#
# Diffusion youtube avec ffmpeg

# Configurer youtube avec une résolution 720p. La vidéo n'est pas scalée.

VBR="5000k"                                    # Bitrate de la vidéo en sortie
FPS="30"                                       # FPS de la vidéo en sortie
QUAL="medium"                                  # Preset de qualité FFMPEG
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"  # URL de base RTMP youtube

SOURCE_VID=""              # .mp4
SOURCE_AUD=""              # .mp3
KEY=""                 # Clé à récupérer sur l'event youtube

ffmpeg \
 -stream_loop -1 \
 -re \
 -i "$SOURCE_VID" \
 -thread_queue_size 512 \
 -stream_loop -1 \
 -i "$SOURCE_AUD" \
 -c:v libx264 -preset "$QUAL" -r "$FPS" -g "$FPS" -b:v "$VBR" \
 -c:a aac -threads 6 -ar 44100 -b:a 128k -bufsize 512k -pix_fmt yuv420p -s 1920x1080 \
 -fflags +shortest -max_interleave_delta 50000 \
 -f flv "$YOUTUBE_URL/$KEY"
