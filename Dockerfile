FROM debian:jessie

RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

ENV GOSU_VERSION 1.7
RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget curl && rm -rf /var/lib/apt/lists/* \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& apt-get purge -y --auto-remove ca-certificates


COPY jdk-7u80-linux-x64.tar.gz /
RUN tar zxvf /jdk-7u80-linux-x64.tar.gz 

RUN wget http://ftp.tc.edu.tw/pub/Apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz -P /opt \
    && cd /opt && tar zxvf /opt/apache-tomcat-7.0.73.tar.gz

ENV JAVA_HOME /jdk1.7.0_80
ENV PATH /jdk1.7.0_80/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
RUN ls -l
COPY docker-entrypoint1.sh /
ENTRYPOINT ["/docker-entrypoint1.sh"]
RUN ln -s /opt/apache-tomcat-7.0.73/webapps/ /$PGDATA1
