FROM phusion/baseimage:0.9.16
MAINTAINER needo <needo@superhero.org>
#Based on the work of Eric Schultz <eric@startuperic.com>
#Thanks to Tim Haak <tim@haak.co.uk>
ENV DEBIAN_FRONTEND noninteractive

# Set correct environment variables
ENV HOME /root

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# chfn workaround - Known issue within Dockers
RUN ln -s -f /bin/true /usr/bin/chfn

# Add necessary scripts
ADD nfs-configure.sh /usr/local/bin/nfs-configure
ADD plexmediaserver /default_plexmediaserver
ADD firstrun.sh /etc/my_init.d/firstrun.sh
ADD plex.sh /etc/service/plex/run

# Install Dependencies
# Correct permissions on firstrun.sh to execute during container startup
# Add Plex to runit
RUN apt-get -q update && \
	apt-get install -qy gdebi-core wget nfs-common inotify-tools && \
	chmod +x /etc/my_init.d/firstrun.sh && \
	chmod +x /etc/service/plex/run

EXPOSE 32400

ENTRYPOINT ["/usr/local/bin/nfs-configure"]
