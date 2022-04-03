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
FROM ubuntu:20.04

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update -y && apt-get install -y apt-utils
RUN apt-get update -y && apt-get upgrade -y 
RUN apt-get install -y kmod make gcc wget
RUN apt-get install -y file curl wget unzip tar
RUN apt-get install -y fuse

# RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
# RUN dpkg -i packages-microsoft-prod.deb
# RUN rm packages-microsoft-prod.deb

# RUN apt-get update  -y 
# RUN apt-get install -y autotools-dev autoconf-archive gettext intltool libgtk-3-dev

# RUN apt-get install -y apt-transport-https
# RUN apt-get install -y dotnet-sdk-6.0


# RUN apt-get build-dep pinta
# RUN apt-get install git

# RUN git clone https://github.com/PintaProject/Pinta.git ~/pinta
# RUN cd ~/pinta && ./autogen.sh --prefix=~/pinta/build
# RUN cd ~/pinta && make && make install







