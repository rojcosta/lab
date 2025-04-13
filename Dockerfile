# Builder
#build
FROM maven:3.9.9-amazoncorretto-17-alpine AS builder
COPY  . /root/app/
WORKDIR /root/app
RUN --mount=type=cache,target=/root/.m2 mvn clean install -B  -Dmaven.test.skip

#app
FROM amazoncorretto:17.0.14-al2023 AS application
#RUN addgroup --gid 1001 app \
#    && adduser --ingroup app --shell /bin/false --disabled-password --uid 1001 app \
#    && chown app:app .
#RUN mkdir -p /home/app/agent
#USER app
COPY --from=builder /root/app/target/*.jar /home/app/
#COPY opentelemetry-javaagent.jar /home/app/agent/
RUN pwd && ls -l 
WORKDIR /home/app
RUN chmod 0777 /home/app
EXPOSE 8080
ENTRYPOINT java -jar $JAVA_OPTIONS *.jar $APP_ARGS