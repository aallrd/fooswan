# fooswan

A Fedora based development environment using docker.

## Build

    $ docker build --build-arg CACHEBUST=$(date +%s) -t fooswan .

## Run

### From Powershell

    PS> docker rm --force fooswan >null 2>&1
    PS> docker run --rm -d -v fooswan:/vol --net=host -h fooswan --name fooswan fooswan
    # Get the fooswan's container ip address
    PS> docker container exec fooswan zsh -c 'ip route get 1 | awk \"{print \$NF;exit}\"'
    # SSH to this address using Putty
    PS> putty -load fooswan aallrd@fooswan-container-ip

### From a Unix shell

    $ docker rm --force fooswan >/dev/null 2>&1
    $ docker run --rm -d -v fooswan:/vol --net=host -h fooswan --name fooswan fooswan
    # Get the fooswan's container ip address
    $ docker container exec fooswan zsh -c 'ip route get 1 | awk "{print \$NF;exit}"'
    # SSH to this address
    $ ssh aallrd@fooswan-container-ip

## GUI support

The docker host needs to have an X server running.

- MobaXterm (Windows)
  - X11 remote access: `full`

In order to start graphical applications, you need to set the DISPLAY variable on the host and start the docker container with the DISPLAY variable exported:

### From Powershell

    PS> [Environment]::SetEnvironmentVariable("DISPLAY", $env:COMPUTERNAME + ":0.0", "User")
    PS> docker run --rm -d -v fooswan:/vol --net=host -h fooswan --name fooswan -e DISPLAY=$env:DISPLAY fooswan

### From a Unix shell

    $ export DISPLAY="$(hostname)"
    $ docker run --rm -d -v fooswan:/vol --net=host -h fooswan --name fooswan -e DISPLAY="${DISPLAY}" fooswan
