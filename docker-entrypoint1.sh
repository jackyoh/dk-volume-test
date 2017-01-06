#!/bin/bash
set -e
#mkdir -p "$PGDATA"
#chmod 700 "$PGDATA"
#chown -R postgres "$PGDATA"

#mkdir -p "$PGDATA1"
#chmod 700 "$PGDATA1"
#chown -R postgres "$PGDATA1"
#echo "aaaaa">$PGDATA1/aaaa.txt
#echo "bbbbb">$PGDATA1/bbbb.txt

mkdir -p "$TOMCATWEBAPPS/ROOT"
echo "Hello World" > "$TOMCATWEBAPPS/ROOT/hello.html"
grep -v rootfs /proc/mounts > /etc/mtab
df -h > "$TOMCATWEBAPPS/ROOT/df.html"

/opt/apache-tomcat-7.0.73/bin/catalina.sh run -config /server.xml
#cd /opt/apache-tomcat-7.0.73 && sed "s/8080/1234/g" < ./conf/server.xml > ./conf/server-mesos.xml && ./bin/catalina.sh run -config ./conf/server-mesos.xml

exec "$@"
