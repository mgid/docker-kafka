FROM openjdk:8-jre-alpine

EXPOSE 2181/tcp 9092/tcp

ARG KAFKA_VERSION=2.2.1
ARG SCALA_VERSION=2.12

# advertised hostname for kafka listener
ENV KAFKA_ADVERTISED_HOSTNAME=localhost

RUN wget --quiet "http://www.apache.org/dyn/closer.cgi?action=download&filename=/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" -O /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    mkdir -p /opt && \
    tar -C /opt -zxf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    ln -s kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
    rm /tmp/* && \
    # for kafka scripts
    apk add --quiet --no-cache bash

CMD /opt/kafka/bin/zookeeper-server-start.sh -daemon /opt/kafka/config/zookeeper.properties && \
    exec /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties --override advertised.host.name=${KAFKA_ADVERTISED_HOSTNAME}
