#!/bin/bash

formatdownload () {

    echo "What file format would you like to download?"
    echo "1. MP4"
    echo "2. MP3"
    read -s -n 1 format
    printf "\n"

    if [ "$format" = "1" ] || [ "$format" = "MP4" ] || [ "$format" = "mp4" ]
    then
        format=MP4
    else
	    format=MP3
    fi

    echo "Downloading $format..."

    if [[ "$format" = "MP4" ]]
    then
        youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $URL
    else
        youtube-dl -x --audio-format mp3 $URL
    fi
}

echo "Input your URL:"
read URL
echo "$URL" > "awesome.txt"
soundcloudcheck=$(cat awesome.txt | grep 'soundcloud')
twittercheck=$(cat awesome.txt | grep 'twitter')
rm awesome.txt

if [[ $soundcloudcheck ]]; then
    youtube-dl -x --audio-format mp3 $URL
else
    soundcloud=false
fi

if [[ $twittercheck ]] ; then
    youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' $URL
else
    twitter=false
fi

if [[ "$twitter" = "false" ]] && [[ "$soundcloud" = "false" ]]; then
    formatdownload
fi
