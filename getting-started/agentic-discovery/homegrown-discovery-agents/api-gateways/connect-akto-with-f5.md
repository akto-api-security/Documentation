# Connect Akto with F5

F5 is a leading application security and delivery platform that provides advanced traffic management and security features. Integrating F5 with Akto allows automatic discovery and security testing of all APIs flowing through your F5 infrastructure, ensuring comprehensive security coverage across your application delivery network.

<figure><img src="../../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

## **Prerequisites**

1. Go to [app.akto.io](https://app.akto.io). Login/Signup into your account.
2. Click on Quick Start tab in left nav
3. Search for Hybrid SaaS Connector and click connect
4. Copy the token as specified under `Runtime Service Command` heading. This will be later used in setting up Akto Traffic Processor

<figure><img src="../../../../.gitbook/assets/image (64).png" alt=""><figcaption></figcaption></figure>

## Setting Up Akto Traffic Collector

1. Create a new instance
2. Login into the instance and save the following file as docker-compose-traffic-collector.yml

```yaml
version: '2.1'

services:
  zoo1:
    image: confluentinc/cp-zookeeper:6.2.1
    restart: always
    hostname: zoo1
    user: "0"
    volumes:
      - ./data-zoo-data:/var/lib/zookeeper/data
      - ./data-zoo-logs:/var/lib/zookeeper/log
      - ./data-zoo-secrets:/etc/zookeeper/secrets
    container_name: zoo1
    ports:
      - "2181:2181"
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_SERVER_ID: 1
      ZOOKEEPER_SERVERS: zoo1:2888:3888
    labels:
      com.centurylinklabs.watchtower.enable: "false"

  kafka1:
    image: confluentinc/cp-kafka:6.2.1
    restart: always
    hostname: kafka1
    user: "0"
    ports:
      - "9092:9092"
      - "19092:19092"
      - "29092:29092"
      - "9999:9999"
    environment:
      KAFKA_ADVERTISED_LISTENERS: LISTENER_DOCKER_EXTERNAL_DIFFHOST://${AKTO_KAFKA_IP}:9092, LISTENER_DOCKER_INTERNAL://kafka1:19092,LISTENER_DOCKER_EXTERNAL_LOCALHOST://localhost:29092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: LISTENER_DOCKER_EXTERNAL_DIFFHOST:PLAINTEXT, LISTENER_DOCKER_INTERNAL:PLAINTEXT,LISTENER_DOCKER_EXTERNAL_LOCALHOST:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: LISTENER_DOCKER_INTERNAL
      KAFKA_ZOOKEEPER_CONNECT: "zoo1:2181"
      KAFKA_BROKER_ID: 1
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR: 1
      KAFKA_TRANSACTION_STATE_LOG_MIN_ISR: 1
      KAFKA_CREATE_TOPICS: "akto.api.logs:3:3"
      KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS: 60000
      KAFKA_LOG_RETENTION_HOURS: 5
      KAFKA_LOG_SEGMENT_BYTES: 104857600
      KAFKA_LOG_CLEANER_ENABLE: "true"
      KAFKA_CLEANUP_POLICY: "delete"
      KAFKA_LOG_RETENTION_BYTES: 10737418240
    volumes:
      - ./data-kafka-data:/var/lib/kafka/data
      - ./data-kafka-secrets:/etc/kafka/secrets
    depends_on:
      - zoo1
    labels:
      com.centurylinklabs.watchtower.enable: "false"
  akto-api-security-traffic-collector:
    image: ayush12493/udp-packet-reassembler:latest
    env_file: ./docker-akto-collector.env
    restart: always
    mem_limit: 2g
    network_mode: host
    privileged: true
    cap_add:
      - SYS_PTRACE
      - SYS_ADMIN
    volumes:
      - /lib/modules:/lib/modules
      - /sys/kernel:/sys/kernel
      - /:/host
  init-kafka:
    image: confluentinc/cp-kafka:6.2.1
    depends_on:
      - kafka1
    entrypoint: [ '/bin/sh', '-c' ]
    command: |
      "
      # blocks until kafka is reachable
      kafka-topics --bootstrap-server 172.17.0.1:9092 --list

      echo -e 'Creating kafka topics'
      kafka-topics --bootstrap-server 172.17.0.1:9092 --create --if-not-exists --topic akto.api.logs --replication-factor 1 --partitions 2

      echo -e 'Successfully created the following topics:'
      kafka-topics --bootstrap-server 172.17.0.1:9092 --list
      "
```

3. Replace ${AKTO\_KAFKA\_IP} in the above file with your instance’s ip
4. Save below snipped as docker-akto-collector.env. Replace \<traffic\_processor\_instance\_ip> with your instance ip.

```tcl
AKTO_TRAFFIC_BATCH_TIME_SECS=10
AKTO_TRAFFIC_BATCH_SIZE=100
AKTO_KAFKA_BROKER_MAL=<traffic_processor_instance_ip>:9092
AKTO_BYTES_IN_THRESHOLD=10
```

5. Run `docker-compose -f docker-compose-traffic-collector.yml up -d`
6. Expose UDP port 1053 on this instance

## Traffic Processor Setup

1. Login into the Traffic Collector Instance
2. Save the following file as docker-compose-runtime.yml

```yaml
version: '2.1'

services:
  akto-api-security-runtime:
    image: public.ecr.aws/aktosecurity/akto-api-security-mini-runtime:latest
    env_file: ./docker-mini-runtime.env
    mem_limit: 8g
    restart: always
```

3. Save the following file as docker-mini-runtime.env. Replace with token value copied in Prerequisites step. Replace \<traffic\_processor\_instance\_ip> with your instance ip.

```
AKTO_CONFIG_NAME=staging
AKTO_KAFKA_TOPIC_NAME=akto.api.logs
AKTO_KAFKA_BROKER_URL=traffic_processor_instance_ip>:9092
AKTO_KAFKA_BROKER_MAL=traffic_processor_instance_ip>:9092
AKTO_KAFKA_GROUP_ID_CONFIG=asdf
AKTO_KAFKA_MAX_POLL_RECORDS_CONFIG=100
AKTO_ACCOUNT_NAME=Helios
AKTO_TRAFFIC_BATCH_SIZE=100
AKTO_TRAFFIC_BATCH_TIME_SECS=10
USE_HOSTNAME=true
AKTO_INSTANCE_TYPE=RUNTIME
DATABASE_ABSTRACTOR_SERVICE_URL=https://cyborg.akto.io
DATABASE_ABSTRACTOR_SERVICE_TOKEN=<token>
RUNTIME_MODE=hybrid
```

4. Run `docker-compose -f docker-compose-traffic-collector.yml up -d`

## F5 Setup

### Node Setup

1. Create a new node in your F5 dashboard. Use the ip of Traffic Collector instance as Address

### Pool Setup

1. Create a new pool in your F5 dashboard.
   1. Address - Use the ip of Traffic Collector instance
   2. Service Port - 1053

### IRULE

1. Create a new iRule with the following tcl script

```tcl
when RULE_INIT {
    set static::hsl_start "${static::delimiter}HSL_START${static::delimiter}"
    set static::delimiter "__"
    set static::request_header_start "${static::delimiter}REQHS${static::delimiter}"
    set static::request_header_end "${static::delimiter}REQHE${static::delimiter}"
    set static::header_name "${static::delimiter}HEAN${static::delimiter}"
    set static::header_value "${static::delimiter}HEAV${static::delimiter}"
    set static::response_header_start "${static::delimiter}RESPHS${static::delimiter}"
    set static::response_header_end "${static::delimiter}RESPHE${static::delimiter}"
    set static::max_collect_len 10000
    set static::request_payload "${static::delimiter}REQPS${static::delimiter}"
    set static::response_payload "${static::delimiter}REQPE${static::delimiter}"
    set static::hsl_end "${static::delimiter}HSL_END${static::delimiter}"
}

when CLIENT_ACCEPTED {
    set hsl [HSL::open -proto UDP -pool trafficpoolnew]
    set sessionId "[IP::client_addr][TCP::client_port][IP::local_addr][TCP::local_port][expr { int(100000000 * rand()) }]"
    binary scan [md5 $sessionId] H* correlationId junk
}

when HTTP_REQUEST {
    set request_time [clock clicks -milliseconds]
    set reqHeaderString "${static::request_header_start}"
    set contentTypeHeaderValue ""
    foreach aHeader [HTTP::header names] {
      if { [string tolower $aHeader] == "content-type" } {
        set contentTypeHeaderValue [HTTP::header value $aHeader]
      }
      set lwcasekey [string map -nocase {"\\"" "\\\\\\""}[string tolower $aHeader]]
      set value [string map -nocase {"\\"" "\\\\\\""} [HTTP::header value $aHeader]]
      set headers "${static::header_name}${lwcasekey}${static::header_value}${value}"
      append reqHeaderString $headers
    }
    append reqHeaderString ${static::request_header_end}
    set uri [HTTP::uri]
    set method [HTTP::method]
    set client_addr [IP::client_addr]
    set local_port [TCP::local_port]
    set method [HTTP::method]
    set host [HTTP::host]
    set request_time [clock clicks -milliseconds]
    set request_payload ""

}

when HTTP_REQUEST_DATA {
    if {[HTTP::payload length] > 0 } {
        set capture_length [HTTP::payload length]
        if { $capture_length >  $static::max_collect_len } {
          set capture_length $static::max_collect_len
        }
        set request_payload [b64encode [string range "[HTTP::payload]" 0 $capture_length ]]
    }
}

when HTTP_RESPONSE  {
    set response_time [clock clicks -milliseconds]
    set resHeaderString "${static::response_header_start}"
    foreach aHeader [HTTP::header names] {
      set lwcasekey [string map -nocase {"\\"" "\\\\\\""}[string tolower $aHeader]]
      set value [string map -nocase {"\\"" "\\\\\\""} [HTTP::header value $aHeader]]
      set headers "${static::header_name}${lwcasekey}${static::header_value}${value}"
      append resHeaderString $headers
    }
    append resHeaderString "${static::response_header_end}"

    HTTP::collect $static::max_collect_len
    set forwarded_data 0
    if { [HTTP::header exists "Content-Length"] && [HTTP::header value "Content-Length"] == 0 } {
       set response_payload ""
       HSL::send $hsl "${static::hsl_start}$correlationId $method $uri $client_addr $local_port [HTTP::status] $host [HTTP::version] $request_time $response_time $reqHeaderString $resHeaderString ${static::request_payload}$request_payload ${static::response_payload}$response_payload ${static::hsl_end}\\n"
       set forwarded_data 1
    }
}

when HTTP_RESPONSE_DATA {
    set response_payload ""
    if { [HTTP::payload length] > 0 } {
        set capture_length [HTTP::payload length]
        if { $capture_length >  $static::max_collect_len } {
          set capture_length $static::max_collect_len
        }
        set response_payload [b64encode [string range "[HTTP::payload]" 0 $capture_length]]
    }
    if { $forwarded_data != 1 } {
        HSL::send $hsl "${static::hsl_start} ${static::hsl_start} ${static::hsl_start} ${static::hsl_start} ${static::hsl_start} ${static::hsl_start} $correlationId $method $uri $client_addr $local_port [HTTP::status] $host [HTTP::version] $request_time $response_time $reqHeaderString $resHeaderString ${static::request_payload}$request_payload ${static::response_payload}$response_payload ${static::hsl_end}\\n"
    }
}
```

2. Attach the iRule to your virtual server by going to resources section under your virtual server.
