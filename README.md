# [Docker dnn_reco](https://hub.docker.com/r/theludwig/dnn_reco)
Dockerfiles to create some basic dnn_reco environment. You can find images on [docker-hub](https://hub.docker.com/r/theludwig/dnn_reco).

My template was [this icetray Dockerfile](https://github.com/WIPACrepo/docker-icecube-icetray/blob/master/ubuntu20.04/combo/stable/Dockerfile_tensorflow2.4.1). 
The dnn_reco repository can be found [here](https://github.com/icecube/dnn_reco).

## The tags

#### base / latest
The image from `Dockerfile` has dnn_reco already installed. You are logged in as user `dnn` with password `reco` and you will find 
the dnn_reco repository in your homefolder (`/home/dnn`).

#### dependencies
The image from `Dockerfile.dependencies` only has the prerequisites for `dnn_reco` installed. This is optimal if you want to bind a 
folder and install dnn_reco yourself. This is for example the case if your DNN_HOME folder already exists elsewhere or you simply want 
to keep it.

#### icetray
The tags with icetray in the name have the correct environment variables, so that icetray is already loaded. 


## Usage

To start a container and log in (if you use an `icetray` tag, `icetray` environment is loaded, if not, execute `/usr/local/icetray/env-shell.sh` 
*in its folder* (or `$I3_BUILD/env_shell.sh`):
```sh
docker run -it theludwig/dnn_reco
```

## Singularity
To build a singularity sandbox container with this image run:

```sh 
sudo SINGULARITY_TMPDIR=/path/with/enough/space/which/is/about/10/gb singularity build --sandbox ./dnn_reco.sif docker://theludwig/dnn_reco
```
To log on to the container run: 
```sh 
sudo singularity shell --no-home --writable dnn_reco.sif
```

(if you don't specify `--no-home`, dnn_reco won't be available in `/root`, as it gets overwritten by whatever you have there) 


## Build 

To build the image run 
```sh
docker build - < Dockerfile
```
in this repo with enough privileges (use `sudo` or be in the `docker` user group).



