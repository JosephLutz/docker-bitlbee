FROM alpine:edge
MAINTAINER Joseph Lutz <Joseph.Lutz@novatechweb.com>

# Install the packages
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk add --update \
      bitlbee \
      bitlbee-facebook@testing \
      su-exec \
 && rm -rf /var/cache/apk/*

# Setup the bitlbee user for the service to run as
RUN adduser -h /var/lib/bitlbee -H -s /sbin/nologin -D bitlbee

RUN mkdir /var/run/bitlbee \
 && chown bitlbee:bitlbee /var/run/bitlbee

# copy over files
COPY ./docker-entrypoint.sh \
    /

# specify the volumes directly related to this image
VOLUME [ "/var/lib/bitlbee" ]

# specify which network ports will be used
EXPOSE 6667

# start the entrypoint script
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bitlbee"]
