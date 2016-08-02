#!/bin/sh

case ${1} in
    bitlbee)
    chown -R bitlbee:bitlbee /var/lib/bitlbee
    exec su-exec bitlbee bitlbee -D -n -v -P /var/run/bitlbee/bitlbee.pid
        ;;

    *)
        # run some other command in the docker container
        exec "$@"
        ;;
esac

