FROM 1science/sbt sbt clean assembly as BUILD

COPY . /root/
WORKDIR /root/
RUN sbt clean assembly

FROM openjdk:8-jre-alpine

COPY --from=BUILD /root/target /root/
WORKDIR /root/
CMD ["/bin/bash", "-c", "find -type f -name '*-with-dependencies.jar' | xargs java -jar"]
