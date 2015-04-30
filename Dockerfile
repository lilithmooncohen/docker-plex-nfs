FROM phusion/baseimage:0.9.16

ENV DEBIAN_FRONTEND noninteractive

ENV HOME /root

ADD nfs-configure.sh /usr/local/bin/nfs-configure
ADD plexmediaserver /default_plexmediaserver
ADD firstrun.sh /etc/my_init.d/firstrun.sh
ADD plex.sh /etc/service/plex/run

RUN ln -s -f /bin/true /usr/bin/chfn && \
	apt-get -q update && \
	apt-get install -qy gdebi-core wget nfs-common inotify-tools && \
	chmod +x /etc/my_init.d/firstrun.sh && \
	chmod +x /etc/service/plex/run

CMD ["/sbin/my_init"]

EXPOSE 32400

ENTRYPOINT ["/usr/local/bin/nfs-configure"]