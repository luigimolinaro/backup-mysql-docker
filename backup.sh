#!/bin/bash
containers=$(docker ps | grep 'mysql\|maria' | awk {'print $NF'})

for container in $containers
do
  containerStringParts=$(echo $container | tr "." "\n")

  for single in $containerStringParts
  do
          simpleName=$single
          break 1
  done

  timestamp=$(date +%Y-%m-%d_%H-%M-%S)
  docker exec $container sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /root/backups/$simpleName-$timestamp.sql
done
