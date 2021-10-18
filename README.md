# Chrome Sandbox

This is a fully functional Ubuntu desktop running Xorg and Fluxbox inside of a docker container.  This allows you to access suspicious websites or execute potentially dangerous code while keeping the host machine safe.  Stopping/Starting the container creates a completely fresh session.

Consider this a POC - many improvements can and should be made before this is usable.

This example uses podman for container orchestration, if you're using docker instead just replace podman in these commands with docker and it should work the same.


### Build container

`podman build -t chrome-sandbox .`

### Start container

`podman run -d -p 5900:5900 -e VNC_SERVER_PASSWORD=password --user chrome --privileged chrome-sandbox`


Connect to `localhost:5900` with any VNC client

## Caveats
This container is huge and at least with podman the default VM does not have a large enough disk to build the entire image.  The workaround for this is destroying the default VM and creating one with a larger disk 

```
podman machine stop
podman machine rm
podman machine init --disk-size 25
podman machine start
```
