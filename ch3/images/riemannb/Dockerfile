# This Dockerfile creates the host called riemannb in the exercises for
# The Art of Monitoring ASIN: B01GU387MS
# This image is expected to be run as a service in a Docker Swarm
FROM centos:7
MAINTAINER jbuchanan@rapid7.com
RUN yum update -y && yum install -y epel-release && yum update -y &&  yum install -y \
	java-1.7.0-openjdk  \
	ruby \
	ruby-devel \
	gcc \
	libxm12-devel \ 
	wget \
	daemonize \
	&& wget https://aphyr.com/riemann/riemann-0.2.11-1.noarch.rpm \
	&& rpm -Uvh riemann-0.2.11-1.noarch.rpm \
	&& gem install --no-ri --no-rdoc riemann-tools
COPY riemann.config /etc/riemann/riemann.config
COPY email.clj /etc/riemann/examplecom/etc/email.clj
EXPOSE 5556 5556/udp 5555 5555/udp
ENTRYPOINT ["riemann"]
CMD ["/etc/riemann/riemann.config"]

