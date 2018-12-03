#!/bin/sh
#Simple shell script to download stable source tar from the Gstreamer tar repo
printf "\nEnter Gstreamer version\n\n"
read -r version

printf "\nEnter operation command download, untar, build,build-make-install,make-install or uninstall-distclean\n\n"
read -r cmd
INSTALL_PATH=/usr/local

if [[ ! -z GST_PATH ]]; then
    echo "GST_PATH is not set"
elif [[ -z "$GST_PATH" ]]; then
    echo "GST_PATH is set to the empty string"
else
    echo "GST_PATH has the value: $GST_PATH"

INSTALL_PATH=$GST_PATH
fi
numCPU=$(grep -c ^processor /proc/cpuinfo)
buildFunction11()
{
  cd $1
  case $2 in

        build)
          ./autogen.sh --prefix=$INSTALL_PATH --disable-gtk-doc --disable-docbook
        ;;

        build-install)
          ./autogen.sh --prefix=$INSTALL_PATH --disable-gtk-doc --disable-docbook; make -j $numCPU -s install
        ;;

        make-install)
          make -j $numCPU -s install
        ;;

        clean)
          make -j $numCPU clean
        ;;

        uninstall-distclean)
          make -j $numCPU uninstall; make -j $numCPU distclean
        ;;

  esac
  cd ../
}
###
# Main body of script starts here
###

case $cmd in
  download)
    wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-$version.tar.xz
    wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-$version.tar.xz
    wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-$version.tar.xz
    wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-$version.tar.xz
    wget https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-$version.tar.xz
    wget https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-$version.tar.xz
  ;;

  untar)
   tar xf gstreamer-$version.tar.xz
   tar xf gst-plugins-base-$version.tar.xz
   tar xf gst-plugins-base-$version.tar.xz
   tar xf gst-plugins-good-$version.tar.xz
   tar xf gst-plugins-bad-$version.tar.xz
   tar xf gst-plugins-ugly-$version.tar.xz
   tar xf gst-libav-$version.tar.xz
  ;;

  build | build-install | make-install | clean | uninstall-distclean)
   buildFunction11 gstreamer-$version $cmd
   buildFunction11 gst-plugins-base-$version $cmd
   buildFunction11 gst-plugins-good-$version $cmd
   buildFunction11 gst-plugins-bad-$version $cmd
   buildFunction11 gst-plugins-ugly-$version $cmd
   buildFunction11 gst-libav-$version $cmd
  ;;

 *)
        echo "Invalid command\nUsage\nsh buildutility.sh [build,build-make-install,make-install,uninstall-distclean]"
 ;;
esac
