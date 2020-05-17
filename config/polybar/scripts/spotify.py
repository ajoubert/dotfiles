#!/usr/bin/env python3

import dbus
import logging

trunclen = 25

try:
    session_bus = dbus.SessionBus()
    try:
        spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")
    except Exception as e:
        spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotifyd", "/org/mpris/MediaPlayer2")

    spotify_properties = dbus.Interface(spotify_bus, "org.freedesktop.DBus.Properties")

    metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")

    artist = metadata['xesam:artist'][0]
    song = metadata['xesam:title']

    if len(song) > trunclen:
        song = song[0:trunclen]
        song += '...'
        if ('(' in song) and (')' not in song):
            song += ')'

    output = artist + ': ' + song
    print(output)
except dbus.DBusException as e:
    print("")
except Exception as e:
    logging.error(e)
