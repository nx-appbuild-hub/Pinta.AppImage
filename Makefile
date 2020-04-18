SOURCE="https://github.com/PintaProject/Pinta/releases/download/1.6/pinta-1.6.tar.gz"
DESTINATION="build.tar.gz"
OUTPUT="Pinta.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget -O $(DESTINATION)  $(SOURCE)
	
	tar -zxvf $(DESTINATION)
	rm -rf AppDir/opt
	
	mkdir --parents AppDir/opt/application
	cp -r pinta-1.6/* AppDir/opt/application

	#chmod +x AppDir/AppRun
	#export ARCH=x86_64; appimagetool AppDir $(OUTPUT)

	#chmod +x $(OUTPUT)

	#rm -rf pinta-1.6
	#rm -f $(DESTINATION)
	#rm -rf AppDir/opt

