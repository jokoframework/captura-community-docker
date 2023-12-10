FROM maven:3.6.0-jdk-8-slim 
VOLUME /root/.m2
RUN mkdir -p /home/captura/captura-exchange
RUN mkdir -p /home/captura/captura-form_definitions-community
COPY captura-exchange-community/src /home/captura/captura-exchange/src
COPY captura-form_definitions-community/src /home/captura/captura-form_definitions-community/src
COPY captura-formserver-community /home/captura/captura-formserver-community

COPY captura-exchange-community/pom.xml /home/captura/captura-exchange
COPY captura-form_definitions-community/pom.xml /home/captura/captura-form_definitions-community

WORKDIR /home/captura/captura-exchange
#RUN --mount source=maven-repo,destination=/root/.m2 mvn -f /home/captura/captura-exchange/pom.xml -DskipTests clean package
RUN mvn -f /home/captura/captura-exchange/pom.xml -Dmaven.source.skip=true -Dmaven.javadoc.skip=true -DskipTests clean install
WORKDIR /home/captura/captura-form_definitions-community
#RUN --mount source=maven-repo,destination=/root/.m2 mvn -f /home/captura/captura-form_definitions-community/pom.xml -DskipTests clean package
RUN mvn -f /home/captura/captura-form_definitions-community/pom.xml -Dmaven.source.skip=true -Dmaven.javadoc.skip=true -DskipTests clean install

WORKDIR /home/captura/captura-formserver-community
RUN mvn -f /home/captura/captura-formserver-community/pom.xml -Dmaven.source.skip=true -Dmaven.javadoc.skip=true -DskipTests clean package

ENV APP_PORT=8181 \
 SPRING_DATASOURCE_URL="jdbc:postgresql://dbdesa02.dncp.gov.py:5432/db_reinge20210413" 

