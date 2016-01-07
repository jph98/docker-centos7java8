##################################
# Centos, Java and Maven container
##################################

FROM docker.io/centos:7
MAINTAINER Jonathan Holloway <jonathan.holloway@gmail.com>

RUN yum -y update && yum clean all
	
#Java
#####

WORKDIR /opt

ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 66
ENV JAVA_VERSION_BUILD 17
ENV JAVA_PACKAGE server-jre

RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
  http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz | tar -xzf - -C /opt

RUN ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/java

ENV JAVA_HOME /opt/java
ENV PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

#Maven
######

WORKDIR /opt

ENV MAVEN_VERSION 3.3.9

RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /opt
RUN ln -s /opt/apache-maven-$MAVEN_VERSION /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /opt/maven