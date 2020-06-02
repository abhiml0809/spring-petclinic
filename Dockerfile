FROM alpine/git as clone
WORKDIR /app
RUN git clone https://github.com/abhiml0809/spring-petclinic.git

FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=clone /app/spring-petclinic /app
RUN mvn install

FROM openjdk:8-jre-alpine
WORKDIR /app
copy --from=build /app/target/spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar /app/petclinic.jar
EXPOSE 8080
ENTRYPOINT ["sh", "-c"]

CMD ["java -jar petclinic.jar"]








