#!/bin/bash

set -exuo pipefail

rm ./wall*.jpg

TIMESTAMP=$(date +%s)
WALLPAPER_FILE="./wall_${TIMESTAMP}.jpg"
WALLPAPER_PATH=$(realpath $WALLPAPER_FILE)
UNSPLASH_URL=https://source.unsplash.com/1920x1080/?
SEARCH_QUERY=green,simple

wget -O $WALLPAPER_PATH $UNSPLASH_URL$SEARCH_QUERY

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
    var allDesktops = desktops();
    print (allDesktops);
    for (i=0;i<allDesktops.length;i++) {
        d = allDesktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper',
                                    'org.kde.image',
                                    'General');
        d.writeConfig('Image', 'file://${WALLPAPER_PATH}')
    }"
