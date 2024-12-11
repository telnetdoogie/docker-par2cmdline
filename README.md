# docker-par2cmdline
Run par from [@animetosho](https://github.com/animetosho)'s [par2cmdline-turbo](https://github.com/animetosho/par2cmdline-turbo) in a Docker image

This docker image is based on alpine linux and installs the par2cmdline-turbo tools for use locally. It's intended to make these tools available from the command line for those that make it more challenging to install binaries like this on their platform of choice

## installation / build:
```
docker image pull telnetdoogie/docker-par2cmdline:latest
```

## usage:
Mount the folder where the files you want to manage are mapped into `/par2_files/` in the container.
```
docker run --rm -v {path to local par files}:/par2_files/ telnetdoogie/docker-par2cmdline {par2 commands}
```
adding no `{par2 commands}` will show the default par2 usage / help.

## example:
Mounting the local folder `/volume1/media/downloads/` into the container and repairing `mybrokenfile.par`
```
docker run --rm -v /volume1/media/downloads/:/par2_files/ telnetdoogie/docker-par2cmdline repair mybrokenfile.par
```
