# Guaranteed Gateway

This is a Sample project which demostrates achieving guaranteed delivery to a HTTP REST endpoint with NATS broker and Ballerina.

## How to run

First download and run [nats streaming server](https://nats.io/download/nats-io/nats-streaming-server/
). This project has been tested with v0.16.0.

Then build the project with following command. This will build modules and produce jar executables in the target directory.

```shell
ballerina build
```

First run the sample backend HTTP service  module executable as follows

```shell
ballerina run target/bin/backend-executable.jar
```

Then you can start gateway  module executable which is the producer to NATS streaming server and consumer module

```shell
ballerina run target/bin/gateway-executable.jar
ballerina run target/bin/consumer-executable.jar
```

Finally you can run the client simulation module executable as follows

```shell
ballerina run target/bin/client-executable.jar
```
