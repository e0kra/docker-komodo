# zen latest

FROM ubuntu:xenial

ENV BUILD_PACKAGES="build-essential pkg-config libcurl4-gnutls-dev libc6-dev libevent-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python zlib1g-dev wget bsdmainutils automake libboost-all-dev libssl-dev libprotobuf-dev protobuf-compiler libqt4-dev libqrencode-dev libdb++-dev ntp ntpdate" \
		RUNTIME_PACKAGES="libasn1-8-heimdal libc6 libcomerr2 libcurl3-gnutls libffi6 libgcc1 libgmp10 libgnutls30 libgomp1 libgssapi-krb5-2 libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhogweed4 libhx509-5-heimdal libidn11 libk5crypto3 libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 libldap-2.4-2 libnettle6 libp11-kit0 libroken18-heimdal librtmp1 libsasl2-2 libsqlite3-0 libstdc++6 libtasn1-6 libwind0-heimdal zlib1g"

RUN \
	apt-get update && apt-get install -y $BUILD_PACKAGES && \
	cd ~ && git clone https://github.com/jl777/komodo.git && cd ~/komodo && \
	git checkout dPoW && ./zcutil/build.sh -j$(nproc) && \
	cd ~/komodo/src && cp komodo-cli komodo-tx komodod /usr/local/bin/ && rm -rf ~/komodo && \
	apt-get remove --purge -y $BUILD_PACKAGES $(apt-mark showauto) && \
	apt-get install -y $RUNTIME_PACKAGES && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 7771/tcp 7770/tcp
VOLUME [ "/root/.komodo", "/root/.zcash-params" ]
ENTRYPOINT [ "/usr/local/bin/komodod" ]
