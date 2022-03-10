From theludwig/dnn_reco:dependencies AS dependencies

RUN useradd --create-home dnn
# set the password of dnn to reco
RUN echo 'dnn:reco' | chpasswd

# set user to dnn 
USER dnn
WORKDIR /home/dnn

# install dnn_reco 
RUN git clone https://github.com/icecube/dnn_reco.git \
    && pip3 install --user --editable dnn_reco

# set the standard dnn env variable 
ENV DNN_HOME=/home/dnn
RUN mkdir --parents /home/dnn/configs
ENV CONFIG_DIR=/home/dnn/configs

# provide the entry point to run commands
ENTRYPOINT ["/bin/bash", "/usr/local/icetray/env-shell.sh", "exec"]
CMD ["/bin/bash"]
