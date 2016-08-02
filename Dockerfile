FROM alpine:edge
MAINTAINER Joseph Lutz <Joseph.Lutz@novatechweb.com>

# copy over files
COPY root /

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

# specify the volumes directly related to this image
VOLUME /data

# specify which network ports will be used
EXPOSE 6667

# start the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bitlbee"]
