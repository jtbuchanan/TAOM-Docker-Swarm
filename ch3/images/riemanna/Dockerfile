# This Dockerfile creates the host called riemanna in the exercises for
# The Art of Monitoring ASIN: B01GU387MS
# This image is expected to be run as a service in a Docker Swarm
FROM ubuntu:14.04
MAINTAINER jbuchanan@rapid7.com
RUN apt-get update && apt-get install -y \
	default-jre \
	ruby2.0 \
	ruby2.0-dev \
	build-essential \
	zlib1g-dev \ 
	wget \
	&& wget https://aphyr.com/riemann/riemann_0.2.11_all.deb \
	&& dpkg -i riemann_0.2.11_all.deb \
	&& gem2.0 install --no-ri --no-rdoc riemann-tools \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 5556 5556/udp 5555 5555/udp
ENTRYPOINT ["riemann"]
CMD ["/etc/riemann/riemann.config"]

