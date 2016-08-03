#!/bin/sh

case ${1} in
    bitlbee)
        if [[ ! -w /etc/bitlbee/bitlbee.conf ]]; then
            # Restore default config
            pushd /etc/bitlbee \
              && tar -xf /etc/bitlbee.default.config.tgz
            popd
        fi
        chown -R bitlbee:bitlbee /var/lib/bitlbee
        exec su-exec bitlbee bitlbee -D -n -v -P /var/run/bitlbee/bitlbee.pid
        ;;

    *)
        # run some other command in the docker container
        exec "$@"
        ;;
esac

