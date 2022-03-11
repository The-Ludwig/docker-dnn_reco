From theludwig/dnn_reco:dependencies AS dependencies

ARG USER=dnn
ARG PW=reco

RUN useradd --create-home $USER
# set the password of dnn to reco
RUN echo "${USER}:${PW}" | chpasswd

# set user to dnn 
USER $USER
WORKDIR /home/$USER

# install dnn_reco 
RUN git clone https://github.com/icecube/dnn_reco.git \
    && pip3 install --user --editable dnn_reco

# set the standard dnn env variable 
RUN mkdir --parents /home/$USER/configs
ENV DNN_HOME=/home/$USER \
    CONFIG_DIR=/home/$USER/configs

# provide the entry point to run commands
ENTRYPOINT ["/bin/bash", "/usr/local/icetray/env-shell.sh", "exec"]
CMD ["/bin/bash"]
