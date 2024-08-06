FROM alpine AS download

ARG KAFKA_VERSION=3.8.0
ARG SCALA_VERSION=2.13

RUN wget --quiet "https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz" -O /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz
RUN tar -C /tmp -zxf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    mv /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /tmp/kafka


FROM openjdk:8-jre-slim

EXPOSE 9092/tcp

# advertised hostname for kafka listener
ENV KAFKA_ADVERTISED_HOSTNAME=localhost
# default number of log partitions per topic
ENV KAFKA_NUM_PARTITIONS=1
# add kafka bin to PATH
ENV PATH=/opt/kafka/bin:${PATH}

COPY --from=download /tmp/kafka /opt/kafka

COPY server.properties /opt/kafka/config/server.properties

RUN /opt/kafka/bin/kafka-storage.sh format -t $(/opt/kafka/bin/kafka-storage.sh random-uuid) -c /opt/kafka/config/server.properties

CMD exec /opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties --override advertised.listeners=PLAINTEXT://${KAFKA_ADVERTISED_HOSTNAME}:9092 --override num.partitions=${KAFKA_NUM_PARTITIONS}
