FROM 	ubuntu:xenial
MAINTAINER 	sylvain121

ENV 	DEBIAN_FRONTEND=noninteractive
RUN	apt-get update
RUN	apt-get dist-upgrade -y
RUN 	apt-get install g++ build-essential git-core -y
RUN	apt-get build-dep minidlna -y
WORKDIR /tmp
RUN	git clone https://git.code.sf.net/p/minidlna/git minidlna-git
WORKDIR /tmp/minidlna-git
RUN 	./autogen.sh
RUN	./configure
RUN 	make -j4
RUN 	make install
RUN 	apt-get clean
ADD	minidlna.conf /etc/
VOLUME	["/media"]
CMD	["/usr/local/sbin/minidlnad", "-d",  "-R",  "-f /etc/minidlna.conf"]
