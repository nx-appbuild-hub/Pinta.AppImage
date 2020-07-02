OUTPUT="Pinta.AppImage"

all: clean
	echo "Building: $(OUTPUT)"

	mkdir -p ./mono

	wget --output-document=./mono/build.rpm https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/m/mono-core-4.6.2-4.el7.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	wget --output-document=./mono/build.rpm https://rpmfind.net/linux/epel/7/x86_64/Packages/g/gtk-sharp2-2.12.26-4.el7.x86_64.rpm
	cd ./mono && rpm2cpio build.rpm | cpio -idmv && cd ..

	rm -f ./mono/build.rpm

	cp -r ./mono/etc ./AppDir
	cp -r ./mono/usr/* ./AppDir

	rm -rf ./Pinta
	git clone https://github.com/PintaProject/Pinta.git Pinta
	mkdir -p Pinta/build

	cd ./Pinta && ./autogen.sh --prefix=`pwd`/build && cd ..
	cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' Makefile && cd ..
	cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' Makefile.am && cd ..
	cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' Makefile.in && cd ..
	cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' help/Makefile && cd ..
	cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' help/Makefile.am && cd ..
	cd ./Pinta && sed -i 's/@YELP_HELP_RULES@//g' help/Makefile.in && cd ..

	cd ./Pinta && make -i -B && make install && cd ..

	cp -r ./Pinta/build/* ./AppDir
	chmod +x ./AppDir/AppRun

	chmod +x AppDir/AppRun
	export ARCH=x86_64; bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)
	make clean

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
