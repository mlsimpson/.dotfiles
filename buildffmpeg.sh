#!/bin/sh

sudo apt-get update
sudo apt-get upgrade

mkdir /home/threv/ffmpeg_sources

cd /home/threv/ffmpeg_sources
git clone --depth 1 git://git.videolan.org/x264.git
cd x264
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
make
make install
make distclean

cd /home/threv/ffmpeg_sources
git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git
cd fdk-aac
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /home/threv/ffmpeg_sources
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
./configure --prefix="$HOME/ffmpeg_build" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfaac \
  --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libtheora \
  --enable-libvorbis --enable-libvpx --enable-libx264 --enable-nonfree \
  --enable-libspeex --enable-libgme
make
make install
make distclean
hash -r

cd /home/threv/bin
sudo cp -rv * /usr/local/bin
cd /home/threv/ffmpeg_build
sudo cp -rv * /usr/local

rm -rf /home/threv/bin
rm -rf /home/threv/ffmpeg_sources
rm -rf /home/threv/ffmpeg_build
rm -rf /home/threv/x264
