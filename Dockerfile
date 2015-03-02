FROM phusion/baseimage:0.9.16
MAINTAINER Simon Elsbrock <simon@iodev.org>

ENV LANG en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

RUN \
    echo "Acquire::Languages \"none\";\nAPT::Install-Recommends \"true\";\nAPT::Install-Suggests \"false\";" > /etc/apt/apt.conf ;\
    echo "Europe/Berlin" > /etc/timezone && dpkg-reconfigure tzdata ;\
    locale-gen en_US.UTF-8 en_DK.UTF-8 de_DE.UTF-8 ;\
    apt-get -q -y update ;\
    apt-get install -y nginx-light rsync ;\
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN \
    echo "daemon off;" >> /etc/nginx/nginx.conf ;\
    mkdir /etc/service/nginx ;\
    echo "#!/bin/sh\n/usr/sbin/nginx" > /etc/service/nginx/run ;\
    chmod +x /etc/service/nginx/run

RUN \
    adduser --system --uid 9999 --disabled-password --gecos "" deploy --shell /bin/sh ;\
    echo "#!/bin/sh\nchown deploy /data" > /etc/rc.local && chmod +x /etc/rc.local ;\
    mkdir /home/deploy/.ssh

ADD deploy_key.pub /home/deploy/.ssh/authorized_keys
ADD nginx.conf /etc/nginx/sites-available/default

VOLUME "/data"

EXPOSE 80
