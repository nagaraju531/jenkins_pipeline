FROM tomcat:latest
LABEL maintainer="RAJU"
ADD ./target/GUI-Application-002v.war /usr/local/tomcat/webapps/
EXPOSE 8070
CMD ["catalina.sh", "run"]
