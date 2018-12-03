#!/bin/sh
#Simple shell script to download stable source tar from the Gstreamer tar repo
printf "\nEnter Gstreamer version to download\n\n"
read -r version
Downloading veresion: $version
wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-$version.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-$version.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-$version.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-$version.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-$version.tar.xz
wget https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-$version.tar.xz