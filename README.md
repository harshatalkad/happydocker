# Happy Docker 

This project is to be able to run the HAPI FHIR implementation in a Docker container.

Note that this project is specifically intended for end users of the HAPI FHIR JPA server module (in other words, it helps you implement HAPI FHIR, it is not the source of the library itself). If you are looking for the main HAPI FHIR project, see here: https://github.com/hapifhir/hapi-fhir


## Prerequisites

In order to use this project, you should have:

- [This project](https://github.com/harshatalkad/happydocker/tree/hackathon2021) cloned to your local machine.
- Java (JDK) installed: Minimum JDK8 or newer.
- Apache Maven build tool (newest version)
- Being able to run a [Docker](https://docs.docker.com/get-docker/) container on your local machine.


## Building, Starting and Stopping the Container


### Build the image

Here are the step by step instructions along with commands to execute to run the HAPI FHIR server in a Docker container

- Clone the repo 
	- `$ git clone https://github.com/harshatalkad/happydocker.git`
- Change to the project directory in a terminal
	- `$ cd happydocker`
- Build the project 
	- `$ mvn clean install` . (This will take little longer as it runs the tests. You can skip tests using `-DskipTests` flag).
- Build the docker image
	- `$ sh build-docker-image.sh`
- Verify the image is successfully built using command
	- `$ docker images`
	You should see something like below
	```
	REPOSITORY                              TAG       IMAGE ID       CREATED         SIZE
    healthcloud-fhir                        latest    9e57ea20d6c1   5 seconds ago   647MB
	```
	
	
### Launch the Container	
- Launch the container using the following command
	- `$ docker-compose up -d`
- You can look at the logs of the running container by tailing the logs using
	- `$ docker logs -f hc_fhir`
- Also to verify docker image is running you can use the following command
	- `$ docker ps`
- This will run the docker image with the default configuration, mapping port 8080 from the container to port 8090 in the host. Once running, you can access `http://localhost:8090/` in the browser to access the HAPI FHIR server's UI or use `http://localhost:8090/fhir/` as the base URL for your REST requests.
	

### Stop the Container
- You can stop the container using the following command. If you don't delete the stopped container all the test data you have inserted will be available when you start the container again. 
	- `$ docker stop hc_fhir`
- To look at stopped container use the command
	- `$ docker ps -a`
	
### Restart the stopped Container
- You can restart the stopped container using the following command
	- `$ docker start hc_fhir`


## Insert the data
- `$ cd data`
- Read the Readme




