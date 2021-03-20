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

all:

	mkdir --parents $(PWD)/build/Boilerplate.AppDir/pinta
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 libatspi2.0-0 libglib2.0-0 \
												mono-complete libatspi2.0-0 librsvg2-2 libgtk2.0-cil mono-devel

	echo ''																													>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'export MONO_PATH=$${LD_LIBRARY_PATH}'																				>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo ''																													>> $(PWD)/build/Boilerplate.AppDir/AppRun		
	echo 'exec $${APPDIR}/bin/mono-sgen --config $${APPDIR}/etc/mono/config $${APPDIR}/pinta/lib/pinta/Pinta.exe "$$@"' 	>> $(PWD)/build/Boilerplate.AppDir/AppRun


	git clone https://github.com/PintaProject/Pinta.git $(PWD)/build/pinta

	cd $(PWD)/build/pinta && ./autogen.sh --prefix=$(PWD)/build/Boilerplate.AppDir/pinta && cd ..
	cd $(PWD)/build/pinta && make -i -B && make install && cd ..


clean: $(shell rm -rf $(PWD)/build)
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
