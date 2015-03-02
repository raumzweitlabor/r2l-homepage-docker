This is the docker container that is used to serve   
[rzl-homepage](http://github.com/raumzeitlabor/rzl-homepage). It is
automatically being build by and published to the official Docker hub 
(unlisted).

When deploying the service we actually create two containers:
* A container called `rzl-homepage-data` that holds the state (the contents)
and should never be deleted.
* An ephemeral container called `rzl-homepage-web` that runs an nginx webserver
and an SSH daemon for remote deployment (Travis CI). This container is
reachable via a fixed IPv6 address.

Upon (re)start of the service, the latest `rzl-homepage-docker` image is
automatically pulled from the registry and a new `rzl-homepage-web` container is
created, while `rzl-homepage-data` is never touched..

Feel free to send pull requests.

### TODO
* centralized logging using syslog-ng forwarding
