FROM openjdk:8

RUN apt-get update -y && apt-get install maven -y

WORKDIR /code

# Prepare by downloading dependencies
ADD pom.xml /code/pom.xml
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /code/src
RUN ["mvn", "package"]

EXPOSE 4567

RUN java -version && ls -l /usr/bin/java    
RUN wget -O dd-java-agent.jar 'https://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.datadoghq&a=dd-java-agent&v=LATEST'

CMD ["java", "-javaagent:dd-java-agent.jar", "-jar", "target/sparkexample-jar-with-dependencies.jar"]