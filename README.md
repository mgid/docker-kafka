# Kafka test image
Lightweight docker image with Apache Kafka (single broker mode) for development and testing

## Usage

Local run:
```shell
docker run --rm -p 9092:9092 mgid/kafka
```

`.gitlab-ci.yml` example:
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

`docker-compose` example:
```yaml
services:
  kafka:
    image: mgid/kafka:latest
    environment:
      KAFKA_ADVERTISED_HOSTNAME: kafka
```
