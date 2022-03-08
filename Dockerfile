FROM icecube/icetray:combo-stable-install as install-tf

# build NewNuFlux
RUN svn co http://code.icecube.wisc.edu/svn/sandbox/cweaver/NewNuFlux /root/combo/src/NewNuFlux \
           ***REMOVED*** --no-auth-cache

WORKDIR /root/combo/build
RUN cmake /root/combo/src \
      -DCMAKE_BUILD_TYPE=Release \
      -DINSTALL_TOOL_LIBS=OFF \
      -DUSE_GFILT=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local/icetray \
      -DUSE_PYTHON3=OFF \
    && make -j4

# install icetray
RUN make install

### now make the tensorflow image

FROM icecube/icetray:combo-stable-cuda11.1 as dnn_reco

MAINTAINER IceCube <developers@icecube.wisc.edu>

WORKDIR /root

# stage in icetray from the previous build
COPY --from=install-tf /usr/local/icetray /usr/local/icetray

# stage in icetray source from the previous build 
COPY --from=install-tf /root/combo /root/combo

# install tensorflow (right version for dnn_reco) and additional dependencies
RUN pip3 install pybind11 tensorflow==2.3.0 tensorflow_probability==0.11.1 MCEq[MKL]==1.1.1

# set I3 realted environment variables 
ENV I3_SRC=/root/combo/src
ENV I3_BUILD=/usr/local/icetray

# install additional dependencies
RUN pip3 install git+git://github.com/icecube/TFScripts.git \
                 git+git://github.com/icecube/ic3-data.git \
                 git+git://github.com/icecube/ic3-labels.git

# install dnn_reco 
RUN git clone https://github.com/The-Ludwig/dnn_reco.git \
    && pip3 install -e dnn_reco

# set the standard dnn env variables 
ENV DNN_HOME=/root

# provide the entry point to run commands
ENTRYPOINT ["/bin/bash", "/usr/local/icetray/env-shell.sh", "exec"]
CMD ["/bin/bash"]
