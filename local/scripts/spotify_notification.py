#!/usr/bin/env python3

import argparse 
from pathlib import Path
import dbus
import subprocess
from PIL import Image
import requests
from io import BytesIO

parser = argparse.ArgumentParser(description='Displays currently playing song in dunst.')

helpContent = 'Preserve previous notification content. Useful in case you want to manually call this script, as metadata parsing starts failing once the song starts playing.'
parser.add_argument('--preserve', action='store_true',  help=helpContent)

args = parser.parse_args();


TMP_FILE='/tmp/spotify/spotify_notif.tmp'
IMG_FILE='/tmp/spotify/spotify_cover_tmp.jpg'

Path("/tmp/spotify").mkdir(parents=True, exist_ok=True)
TMP_FILE_PATH = Path(TMP_FILE)
TMP_FILE_PATH.touch()

SEPARATOR = " //!!// "

previous_data = Path(TMP_FILE).read_text()

try:
    session_bus = dbus.SessionBus()
    try:
        spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")
    except Exception as e:
        spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotifyd", "/org/mpris/MediaPlayer2")

    spotify_properties = dbus.Interface(spotify_bus, "org.freedesktop.DBus.Properties")

    metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")

    artist = metadata['xesam:artist'][0]
    title = metadata['xesam:title']
    url = metadata['mpris:artUrl']
    response = requests.get(url)
    img = Image.open(BytesIO(response.content))
    img.save(IMG_FILE)
    TMP_FILE_PATH.write_text("%s%s%s" % (artist, SEPARATOR, title))
except Exception as e:
    ## This may happen when metadata is missing (known spotifyd bug)
    caughtException = True

if artist:
    subprocess.run(["dunstify", "-i", IMG_FILE, "-a", "spotifyd", title, artist])
    exit()

if (not args.preserve) or (not previous_data):
    exit()

split = previous_data.split(SEPARATOR)
artist = split[0]
title = split[1]

if title:
    subprocess.run(["dunstify", "-i", IMG_FILE, "-a", "spotifyd", title, artist])
