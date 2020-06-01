#!/usr/bin/env python3

import os.path
import dbus
import logging
import sys

trunclen = 25
TMP_FILE='/tmp/spotify.tmp'

if os.path.isfile(TMP_FILE) == False:
    with open(TMP_FILE, 'a+') as f:
        # Creating empty file when it doesn't exist
        f.write('')

## First, try to get information from dbus
try:
    session_bus = dbus.SessionBus()
    try:
        spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")
    except Exception as e:
        spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotifyd", "/org/mpris/MediaPlayer2")


    spotify_properties = dbus.Interface(spotify_bus, "org.freedesktop.DBus.Properties")

    metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")
    playback_status = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus")

    with open("/tmp/other.tmp", 'w') as m:
        m.write('other')

    artist = metadata['xesam:artist'][0]
    song = metadata['xesam:title']

    if len(song) > trunclen:
        song = song[0:trunclen]
        song += '...'
        if ('(' in song) and (')' not in song):
            song += ')'

    if playback_status == "Playing":
        output = artist + ': ' + song
    else:
        output = ""

    ## Here we have an ouput, let's write it
    with open(TMP_FILE, 'w') as f:
        f.write(output)
        print(output)

except dbus.DBusException as e:
    ## In this case, spotifyd AND spotify are not running, we can exit and print nothing
    nothing_to_print = True

except Exception as e:
    ## In this case, DBus was up but something else went wrong. Let's try to fallback on the file
    with open(TMP_FILE, 'r') as f:
        print(f.read())
