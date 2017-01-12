FROM centos:7.2.1511

RUN yum install -y wget tar
RUN wget http://192.168.1.214/sharefolder/java/jdk-7u71-linux-x64.tar.gz
RUN cd /
RUN tar zxvf jdk-7u71-linux-x64.tar.gz


RUN wget http://ftp.tc.edu.tw/pub/Apache/tomcat/tomcat-7/v7.0.73/bin/apache-tomcat-7.0.73.tar.gz -P /opt \
    && cd /opt && tar zxvf /opt/apache-tomcat-7.0.73.tar.gz
RUN ls -l
ENV JAVA_HOME /jdk1.7.0_71
ENV PATH /jdk1.7.0_71/bin:$PATH

COPY server.xml /
COPY start.sh /
RUN rm -rf /opt/apache-tomcat-7.0.73/conf/server.xml

ENTRYPOINT ["/start.sh"]
