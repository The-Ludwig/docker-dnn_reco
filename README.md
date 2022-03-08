# [Docker dnn_reco](https://hub.docker.com/r/theludwig/dnn_reco)
Dockerfile to create the most basic dnn_reco environment. You can find some images on [docker-hub](https://hub.docker.com/r/theludwig/dnn_reco).

My template was [this icetray Dockerfile](https://github.com/WIPACrepo/docker-icecube-icetray/blob/master/ubuntu20.04/combo/stable/Dockerfile_tensorflow2.4.1). 
The original dnn_reco repository can be found [here](https://github.com/icecube/dnn_reco).


## Usage

To start a container and log in (icetray environment should be loaded, if not, execute/have a look at `/usr/local/icetray/env-shell.sh` or `$I3_BUILD/env_shell.sh`):
```sh
docker run -it theludwig/dnn_reco
```


## Build 

To build the image run 
```sh
docker build - < Dockerfile
```
in this repo with enough privileges (use `sudo` or be in the `docker` user group).



