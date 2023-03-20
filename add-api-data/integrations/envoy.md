# ENVOY

If your API calls are being routed through ENVOY, you can use Akto's ENVOY module to send traffic to Akto dashboard. This module can also be used with istio service mesh, because it is based on ENVOY proxy. Below guide will help you do this:

1. Download the following [repository](https://github.com/akto-api-security/envoy-module) to the folder with envoy.yaml file and rename it as "lib". 
2. Add the following lines to the docker-compose.yaml file for the envoy proxy container.

```
COPY --chmod=777 ./lib/rdkafka /rdkafka
ADD  --chmod=777 ./lib/aktoModule.lua /lib/aktoModule.lua
RUN apt-get update -y
RUN apt-get install librdkafka-dev luarocks -y
RUN luarocks install lua-cjson
```

3. Add the following lines to the envoy.yaml fie under the filters section. For more reference check [this](https://github.com/envoyproxy/envoy/blob/main/examples/lua/envoy.yaml)

```
http_filters:
- name: lua_filter_with_custom_name_0
  typed_config:
    "@type": type.googleapis.com/envoy.extensions.filters.http.lua.v3.Lua
    default_source_code:
      inline_string:
        local aktoModule = require("lib.aktoModule")
        aktoModule.sendToAkto()
```

4. Add an environment variable for AKTO_KAFKA_IP to the docker-compose.yaml file 

```
AKTO_KAFKA_IP=<AKTO_NLB_IP>:9092
```

5. Restart your envoy proxy container.