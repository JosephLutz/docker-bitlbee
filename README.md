# docker-bitlbee
My version of a docker container to run the bitlbee service.

Based from subproject of: https://github.com/xsteadfastx/dockerfiles.git

# What is bitlbee?

> BitlBee brings IM (instant messaging) to IRC clients. It's a great solution for people who have an IRC client running all the time and don't want to run an additional MSN/AIM/whatever client.
> -- <cite>https://www.bitlbee.org</cite>

# How to use this image

```
$ docker run -v /opt/bitlbee/config:/etc/bitlbee -v /opt/bitlbee/users:/var/lib/bitlbee xsteadfastx/bitlbee
```

Connect your irc client to `localhost:6777` and have fun.


# commands I used to create the images
```
docker build --rm --tag docker-bitlbee:latest $(pwd) \
 && docker 2>&1 run --name docker-bitlbee-DV --entrypoint /bin/true docker-bitlbee:latest \
 && docker 2>&1 run -d --restart=always --name docker-bitlbee --volumes-from docker-bitlbee-DV -p :6667:6667 docker-bitlbee:latest
```

# Create backup
```
docker exec -i docker-bitlbee /docker-entrypoint.sh backup > bitlbee.backup.tar
```

# Restore a backup
```
docker exec -i docker-bitlbee /docker-entrypoint.sh restore < bitlbee.backup.tar
docker restart docker-bitlbee
```
