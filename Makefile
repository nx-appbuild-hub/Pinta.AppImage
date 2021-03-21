# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

OUTPUT="Pinta.AppImage"

all: clean
	echo "Building: $(OUTPUT)"

	mkdir -p ./mono

	wget --output-document=./mono/build.rpm https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/m/mono-core-6.8.0-2.el7.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	wget --output-document=./mono/build.rpm https://rpmfind.net/linux/epel/7/x86_64/Packages/g/gtk-sharp2-2.12.26-4.el7.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	wget --output-document=./mono/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk2-2.24.32-4.el8.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	wget --output-document=./mono/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk3-3.22.30-6.el8.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	wget --output-document=./mono/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatk-1_0-0-2.34.1-lp152.1.7.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	wget --output-document=./mono/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatk-bridge-2_0-0-2.34.1-lp152.1.5.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	wget --output-document=./mono/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatspi0-2.34.0-lp152.2.4.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	wget --output-document=./mono/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/librsvg2-2.42.7-4.el8.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..



	rm -f ./mono/build.rpm

	cp -r ./mono/etc ./AppDir
	cp -r ./mono/usr/* ./AppDir

	rm -rf ./Pinta
	git clone https://github.com/PintaProject/Pinta.git Pinta
	mkdir -p Pinta/build

	cd ./Pinta && ./autogen.sh --prefix=`pwd`/build && cd ..
	# cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' Makefile && cd ..
	# cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' Makefile.am && cd ..
	# cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' Makefile.in && cd ..
	# cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' help/Makefile && cd ..
	# cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' help/Makefile.am && cd ..
	# cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' help/Makefile.in && cd ..

	cd ./Pinta && make -i -B && make install && cd ..

	cp -r ./Pinta/build/* ./AppDir
	chmod +x ./AppDir/AppRun

	chmod +x AppDir/AppRun
	export ARCH=x86_64; bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

clean:
	rm -rf ./AppDir/bin
	rm -rf ./AppDir/lib
	rm -rf ./AppDir/lib64
	rm -rf ./AppDir/mono
	rm -rf ./AppDir/pinta
	rm -rf ./AppDir/share
	rm -rf ./AppDir/etc
	rm -rf ./Pinta
	rm -rf ./pinta-*
	rm -rf ./mono
	rm -f ./*.rpm
