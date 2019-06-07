# Kafka test image
Lightweight docker image with Apache Kafka (single broker mode) for development and testing

## Usage

Local run:
```shell
docker run --rm -p 2181:2181 -p 9092:9092 mgid/kafka
```

.gitlab-ci.yml example:
```yaml
integration-test:
  stage: test
  services:
    - name: mgid/kafka:latest
      alias: kafka
  variables:
    KAFKA_ADVERTISED_HOSTNAME: kafka
  ...
```
