#!/bin/sh

rm -f /var/run/bitlbee/bitlbee.pid
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

    backup)
        cd /
        # check files exist
        if [[ ! -w /etc/bitlbee/bitlbee.conf ]]; then
            echo >&2 "bitlbee config file not found before backup: /etc/bitlbee/bitlbee.conf"
            exit 1
        fi
        if [[ ! -d /var/lib/bitlbee ]]; then
            echo >&2 "bitlbee config dir not found before backup: /var/lib/bitlbee"
            exit 1
        fi
        # backup the selected directories
        /bin/tar -cO etc/bitlbee/ var/lib/bitlbee 
        ;;

    restore)
        cd /
        echo >&2 "Extract the archive"
        /bin/tar -xf -
        echo >&2 "Set permissions"
        chown -R bitlbee:bitlbee /var/lib/bitlbee
        # Now restore the database and then use the update script
        if [[ ! -w /etc/bitlbee/bitlbee.conf ]]; then
            echo >&2 "bitlbee config file not found after restore: /etc/bitlbee/bitlbee.conf"
            exit 1
        fi
        ;;

    *)
        # run some other command in the docker container
        exec "$@"
        ;;
esac

