# Happy Docker 

This project is to be able to run the HAPI FHIR implementation in a Docker container.

Note that this project is specifically intended for end users of the HAPI FHIR JPA server module (in other words, it helps you implement HAPI FHIR, it is not the source of the library itself). If you are looking for the main HAPI FHIR project, see here: https://github.com/hapifhir/hapi-fhir

Need Help? Please see: https://github.com/hapifhir/hapi-fhir/wiki/Getting-Help

## Prerequisites

In order to use this sample, you should have:

- [This project](https://github.com/harshatalkad/happydocker/tree/hackathon2021) cloned to your local machine.
- Oracle Java (JDK) installed: Minimum JDK8 or newer.
- Apache Maven build tool (newest version)
- Being able to run a [Docker](https://docs.docker.com/get-docker/) container on your local machine.


This will run the docker image with the default configuration, mapping port 8080 from the container to port 8080 in the host. Once running, you can access `http://localhost:8080/` in the browser to access the HAPI FHIR server's UI or use `http://localhost:8080/fhir/` as the base URL for your REST requests.



## Deploy with docker compose

Docker compose is a simple option to build and deploy container. To deploy with docker compose, you should build the project
with `mvn clean install` and then bring up the containers with `docker-compose up -d --build`. The server can be
reached at http://localhost:8080/.

In order to use another port, change the `ports` parameter
inside `docker-compose.yml` to `8888:8080`, where 8888 is a port of your choice.

The docker compose set also includes my MySQL database, if you choose to use MySQL instead of H2, change the following
properties in application.yaml:

```yaml
spring:
  datasource:
    url: 'jdbc:mysql://hapi-fhir-mysql:3306/hapi'
    username: admin
    password: admin
    driverClassName: com.mysql.jdbc.Driver
```

## Running hapi-fhir-jpaserver directly from IntelliJ as Spring Boot
Make sure you run with the maven profile called ```boot``` and NOT also ```jetty```. Then you are ready to press debug the project directly without any extra Application Servers.

## Running hapi-fhir-jpaserver-example in Tomcat from IntelliJ

Install Tomcat.

Make sure you have Tomcat set up in IntelliJ.

- File->Settings->Build, Execution, Deployment->Application Servers
- Click +
- Select "Tomcat Server"
- Enter the path to your tomcat deployment for both Tomcat Home (IntelliJ will fill in base directory for you)

Add a Run Configuration for running hapi-fhir-jpaserver-example under Tomcat

- Run->Edit Configurations
- Click the green +
- Select Tomcat Server, Local
- Change the name to whatever you wish
- Uncheck the "After launch" checkbox
- On the "Deployment" tab, click the green +
- Select "Artifact"
- Select "hapi-fhir-jpaserver-example:war"
- In "Application context" type /hapi

Run the configuration.

- You should now have an "Application Servers" in the list of windows at the bottom.
- Click it.
- Select your server, and click the green triangle (or the bug if you want to debug)
- Wait for the console output to stop

Point your browser (or fiddler, or what have you) to `http://localhost:8080/hapi/baseDstu3/Patient`

It is important to use MySQL5Dialect when using MySQL version 5+.

## Enabling Subscriptions

The server may be configured with subscription support by enabling properties in the [application.yaml](https://github.com/hapifhir/hapi-fhir-jpaserver-starter/blob/master/src/main/resources/application.yaml) file:

- `hapi.fhir.subscription.resthook_enabled` - Enables REST Hook subscriptions, where the server will make an outgoing connection to a remote REST server

- `hapi.fhir.subscription.email.*` - Enables email subscriptions. Note that you must also provide the connection details for a usable SMTP server.

- `hapi.fhir.subscription.websocket_enabled` - Enables websocket subscriptions. With this enabled, your server will accept incoming websocket connections on the following URL (this example uses the default context path and port, you may need to tweak depending on your deployment environment): [ws://localhost:8080/websocket](ws://localhost:8080/websocket)

## Enabling CQL

Set `hapi.fhir.cql_enabled=true` in the [application.yaml](https://github.com/hapifhir/hapi-fhir-jpaserver-starter/blob/master/src/main/resources/application.yaml) file to enable [Clinical Quality Language](https://cql.hl7.org/) on this server.

## Enabling MDM (EMPI)

Set `hapi.fhir.mdm_enabled=true` in the [application.yaml](https://github.com/hapifhir/hapi-fhir-jpaserver-starter/blob/master/src/main/resources/application.yaml) file to enable MDM on this server.  The MDM matching rules are configured in [mdm-rules.json](https://github.com/hapifhir/hapi-fhir-jpaserver-starter/blob/master/src/main/resources/mdm-rules.json).  The rules in this example file should be replaced with actual matching rules appropriate to your data. Note that MDM relies on subscriptions, so for MDM to work, subscriptions must be enabled.

## Using Elasticsearch

By default, the server will use embedded lucene indexes for terminology and fulltext indexing purposes. You can switch this to using lucene by editing the properties in [application.yaml](https://github.com/hapifhir/hapi-fhir-jpaserver-starter/blob/master/src/main/resources/application.yaml)

For example:

```properties
elasticsearch.enabled=true
elasticsearch.rest_url=localhost:9200
elasticsearch.username=SomeUsername
elasticsearch.password=SomePassword
elasticsearch.protocol=http
elasticsearch.required_index_status=YELLOW
elasticsearch.schema_management_strategy=CREATE
```

## Enabling LastN

Set `hapi.fhir.lastn_enabled=true` in the [application.yaml](https://github.com/hapifhir/hapi-fhir-jpaserver-starter/blob/master/src/main/resources/application.yaml) file to enable the $lastn operation on this server.  Note that the $lastn operation relies on Elasticsearch, so for $lastn to work, indexing must be enabled using Elasticsearch.

## Changing cached search results time

It is possible to change the cached search results time. The option `reuse_cached_search_results_millis` in the [application.yaml] is 6000 miliseconds by default.
Set `reuse_cached_search_results_millis: -1` in the [application.yaml] file to ignore the cache time every search. 

## Build the distroless variant of the image (for lower footprint and improved security)

The default Dockerfile contains a `release-distroless` stage to build a variant of the image
using the `gcr.io/distroless/java-debian10:11` base image:

```sh
docker build --target=release-distroless -t hapi-fhir:distroless .
```

Note that distroless images are also automatically build and pushed to the container registry,
see the `-distroless` suffix in the image tags.

## Adding custom operations

To add a custom operation, refer to the documentation in the core hapi-fhir libraries [here](https://hapifhir.io/hapi-fhir/docs/server_plain/rest_operations_operations.html).

Within `hapi-fhir-jpaserver-starter`, create a generic class (that does not extend or implement any classes or interfaces), add the `@Operation` as a method within the generic class, and then register the class as a provider using `RestfulServer.registerProvider()`.
