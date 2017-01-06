FROM debian:jessie

#RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

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

RUN wget http://192.168.1.214/sharefolder/java/jdk-7u71-linux-x64.tar.gz
RUN cd /
RUN tar zxvf jdk-7u71-linux-x64.tar.gz


RUN wget http://ftp.tc.edu.tw/pub/Apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz -P /opt \
    && cd /opt && tar zxvf /opt/apache-tomcat-7.0.73.tar.gz

ENV JAVA_HOME /jdk1.7.0_71
ENV PATH /jdk1.7.0_71/bin:$PATH

#RUN ls -l
#RUN ls -l
#RUN ls -l
RUN ls -l
RUN ls -l
#RUN rm -f /opt/apache-tomcat-7.0.73/conf/server.xml
COPY server.xml /
COPY docker-entrypoint1.sh /
RUN rm -rf /opt/apache-tomcat-7.0.73/conf/server.xml

ENTRYPOINT ["/docker-entrypoint1.sh"]
