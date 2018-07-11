# fooswan

A Fedora based development environment using docker.

## Build

    $ docker build --build-arg CACHEBUST=$(date +%s) -t fooswan .

## Run

### Interactive

    $ docker run --rm -it -v fooswan:/vol -h fooswan --name fooswan aallrd/fooswan zsh

### SSH

This does not work on Macs because [docker cannot route traffic to containers](https://docs.docker.com/docker-for-mac/networking/#i-cannot-ping-my-containers).

On Windows you may need to add a route to be able to contact the container:

    # 192.168.65.0 is the docker NAT internal subnet
    # 10.0.75.1 is the the docker NAT external IP
    route /P add 192.168.65.0 MASK 255.255.255.0 10.0.75.1

The container is started in daemon mode running sshd, you need to ssh to it to open an interactive session.

#### From Powershell

    PS> docker rm --force fooswan >null 2>&1
    PS> docker run --rm -d -v fooswan:/vol --net=host -h fooswan --name fooswan aallrd/fooswan
    # Get the fooswan's container ip address
    PS> docker container exec fooswan zsh -c 'ip route get 1 | awk \"{print \$NF;exit}\"'
    # SSH to this address using Putty
    PS> putty -load fooswan aallrd@fooswan-container-ip

#### From a Unix shell

    $ docker rm --force fooswan >/dev/null 2>&1
    $ docker run --rm -d -v fooswan:/vol --net=host -h fooswan --name fooswan aallrd/fooswan
    # Get the fooswan's container ip address
    $ docker container exec fooswan zsh -c 'ip route get 1 | awk "{print \$NF;exit}"'
    # SSH to this address
    $ ssh aallrd@fooswan-container-ip

### GUI support

Thanks to the SSH X11 forwarding feature, we can start graphical applications in the container using the host display.

The docker host needs to have an X server running.

- MobaXterm (Windows)
  - X11 remote access: `full`

In order to start graphical applications, you need to set the DISPLAY variable on the host and start the docker container with the DISPLAY variable exported:

### From Powershell

    PS> [Environment]::SetEnvironmentVariable("DISPLAY", $env:COMPUTERNAME + ":0.0", "User")
    PS> docker run --rm -d -v fooswan:/vol --net=host -h fooswan --name fooswan -e DISPLAY=$env:DISPLAY aallrd/fooswan

### From a Unix shell

    $ export DISPLAY="$(hostname)"
    $ docker run --rm -d -v fooswan:/vol --net=host -h fooswan --name fooswan -e DISPLAY="${DISPLAY}" aallrd/fooswan
