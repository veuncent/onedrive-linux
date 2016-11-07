FROM ubuntu

user root

ENV INSTALL_DIR=/install
ENV ONEDRIVE_DIR=/onedrive
ENV CONFIG_DIR=~/.config/onedrive

WORKDIR ${INSTALL_DIR}
RUN apt-get update -y &&\
	apt-get install -y libcurl-dev &&\
	apt-get install -y libsqlite3-dev &&\
	wget http://master.dl.sourceforge.net/project/d-apt/files/d-apt.list -O /etc/apt/sources.list.d/d-apt.list  &&\
	wget -qO - http://dlang.org/d-keyring.gpg | sudo apt-key add -  &&\
	apt-get update &&\
	apt-get install dmd-bin

COPY ./src ${ONEDRIVE_DIR}/src
COPY ./Makefile ${ONEDRIVE_DIR}
COPY ./onedrive.service ${ONEDRIVE_DIR}
WORKDIR ${ONEDRIVE_DIR}
RUN make
RUN make install

RUN mkdir -p ${CONFIG_DIR}
COPY ./onedrive.conf ${CONFIG_DIR}/config

COPY ./install/entrypoint.sh ${INSTALL_DIR}/entrypoint.sh

ENTRYPOINT ${INSTALL_DIR}/entrypoint.sh