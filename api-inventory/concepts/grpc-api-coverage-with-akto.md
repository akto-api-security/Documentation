# gRPC API Coverage with Akto

**Akto** enables you to test and secure your gRPC services with ease. gRPC is a high-performance framework that uses HTTP/2 and Protocol Buffers for fast, type-safe communication. With Akto, you can:

* Discover and visualize gRPC endpoints
* Run functional and security tests
* Identify misconfigurations and risks in real time

Akto decodes and presents gRPC traffic in a human-readable format, even when encrypted, to support thorough testing and analysis.

### What Do gRPC APIs Look Like?

gRPC APIs typically use `POST` requests and are structured as `/ServiceName/MethodName`. They use special headers and content types like `application/grpc-*`.

Here’s an example request captured by Akto:

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

Despite being transmitted over HTTP/2 and often encrypted, Akto decodes the full gRPC request, including method names, headers, and payloads, to support deep inspection and automated testing.

> ✅ Akto reveals full gRPC payloads even if the connection is encrypted.
