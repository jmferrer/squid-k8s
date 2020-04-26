FROM debian:sid

RUN apt-get update && \
    apt-get -y install squid && \
    apt-get clean

# https://github.com/minimum2scp/dockerfiles/tree/master/squid/build/etc/squid
ADD squid.acl.conf /etc/squid/conf.d/squid.acl.conf
ADD squid.local.conf /etc/squid/conf.d/squid.local.conf

EXPOSE 3128

CMD ["/usr/sbin/squid3", "--foreground"]

