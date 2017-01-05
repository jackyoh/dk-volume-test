#!/bin/bash
set -e
mkdir -p "$PGDATA"
chmod 700 "$PGDATA"
chown -R postgres "$PGDATA"

mkdir -p "$PGDATA1"
chmod 700 "$PGDATA1"
chown -R postgres "$PGDATA1"
echo "aaaaa">$PGDATA1/aaaa.txt
echo "bbbbb">$PGDATA1/bbbb.txt

/opt/apache-tomcat-7.0.73/bin/catalina.sh run
ln -s /opt/apache-tomcat-7.0.73/webapps/ $PGDATA1
exec "$@"
