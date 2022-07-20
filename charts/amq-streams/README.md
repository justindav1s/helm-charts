# AMQ Streams Helm Chart

A simple chart that deploys the Kafka Operator (AMQ Streams) and configures `Kafka` and `KafkaTopics`

## 🏃‍♀️ Run it
```bash
# login to OpenShift
oc login ...
oc new-project kafka

Default namespace is labs-dev. Change values in yaml by setting properties from 
command line when installing or upgrading helm charts.

## dry-run
helm upgrade --install my-kafka-cluster . --dry-run

## install
helm install my-kafka-cluster .

## upgrade
helm upgrade --install my-kafka-cluster .
```
# Servicemesh specific information
note that Kafka does not allow sidecar installation as it has its own TLS setup. 
We cannot install servicemesh on kafka

# To enable TLS between Kafka and an application (without istio):
    #use port that is reserved for TLS, port 9093
    my-app\src\main\resources\application.yaml
    kafka:
     endpoint: "kafka:${kafka.topic}"
     topic: ${KAFKA_TOPIC:my-payload}
     brokers: ${KAFKA_BROKER:my-kafka-cluster-kafka-bootstrap:9093}
    #If KAFKA_BROKER is defined as env var, use it, else use the default value



