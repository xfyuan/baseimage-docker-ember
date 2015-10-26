FROM phusion/passenger-nodejs:0.9.17

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ===================
# Install basic stuff
# ===================
RUN apt-get -qq update
RUN apt-get install -y automake

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
	git checkout v3.5.0 &&\
	./autogen.sh &&\
	./configure &&\
	make &&\
	make install &&\
  cd .. && rm -rf watchman


# =======================
# Clean up APT when done.
# =======================
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

