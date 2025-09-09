#!/usr/bin/env bash

set -xeuo pipefail

tee /etc/flatpak/defpaks.list <<EOF
org.mozilla.firefox
org.gnome.Calendar
org.gnome.NautilusPreviewer
com.mattjakeman.ExtensionManager
page.tesk.Refine
org.gtk.Gtk3theme.adw-gtk3
org.gtk.Gtk3theme.adw-gtk3-dark
com.github.tchx84.Flatseal
io.github.flattool.Warehouse
io.github.dvlv.boxbuddyrs
org.gnome.Boxes
org.gnome.World.PikaBackup
com.github.neithern.g4music
io.mpv.Mpv
org.libreoffice.LibreOffice
it.mijorus.gearlever
be.alexandervanhee.gradia
EOF
