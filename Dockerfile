FROM debian:buster

RUN apt-get update && \
    apt-get -y install squid apache2-utils && \
    apt-get clean

# https://github.com/minimum2scp/dockerfiles/tree/master/squid/build/etc/squid
# https://kifarunix.com/how-to-setup-squid-proxy-basic-authentication-with-username-and-password/
#ADD squid.acl.conf /etc/squid/conf.d/squid.acl.conf
ADD squid.local.conf /etc/squid/conf.d/squid.local.conf

ADD docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 3128 3129

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD ["/usr/sbin/squid3", "--foreground"]

