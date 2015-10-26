FROM phusion/passenger-nodejs:0.9.17

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ===================================
# install ember-cli, bower, phantomjs
# ===================================
RUN npm install -g bower
RUN npm install -g ember-cli
RUN npm install -g phantomjs

# ================
# install watchman
# ================
RUN \
	git clone https://github.com/facebook/watchman.git &&\
	cd watchman &&\
	git checkout v4.1.0 &&\
	./autogen.sh &&\
	./configure &&\
	make &&\
	make install


# =======================
# Clean up APT when done.
# =======================
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

