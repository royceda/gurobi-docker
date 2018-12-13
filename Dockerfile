
FROM ubuntu:latest
MAINTAINER Royce Da

ENV GUROBI_INSTALL /opt/gurobi
ENV GUROBI_HOME $GUROBI_INSTALL/linux64
ENV PATH $PATH:$GUROBI_HOME/bin
ENV LD_LIBRARY_PATH $GUROBI_HOME/lib

ARG GUROBI_MAJOR_VERSION=8.1
ARG GUROBI_VERSION=8.1.0
ARG user=gurobi
ARG group=gurobi
ARG uid=1000
ARG gid=1000


#RUN useradd -d /home/gurobi -ms /bin/bash -g root -G sudo -p gurobi gurobi
#USER gurobi


# Install
RUN apt-get update -qq \
&&  apt-get install -yq \
python-dev python-pip python-wheel python-six \
python3-dev python3-pip python3-wheel python3-six \
wget curl gcc nano \
&& apt-get clean 
#&& rm -rf 

    
# Install gurobi
RUN mkdir  /opt/gurobi                                  && \
    wget  https://packages.gurobi.com/6.5/gurobi6.5.1_linux64.tar.gz && \
    tar xvfz gurobi6.5.1_linux64.tar.gz                              && \                     
    cp -rf gurobi651/linux64/ /opt/gurobi/                && \
    rm -rf *.tar.gz      



RUN  cd gurobi651/linux64/ && python setup.py install && cd ../..                   


    # Clean up
#RUN rm -rf ${GUROBI_HOME}/docs                             && \
#    rm -rf ${GUROBI_HOME}/examples                         && \
#    rm -rf ${GUROBI_HOME}/src                              && \
    #rm -rf /var/cache/apk/*                                && \
#    rm -rf /tmp/*                                          && \
#    rm -rf /var/log/*                                      && \
#    rm -rf /gurobi810                                      && \
#    rm /home/gurobi/gurobi${GUROBI_VERSION}_linux64.tar.gz /
    # Remove obsolete packages
    #apk del             \
    #  ca-certificates   \
    #  gzip              \
    #  curl              \
    #  wget

COPY docker-entrypoint.sh /opt/gurobi/linux64/bin
#${GUROBI_HOME}/bin

# Set permissions
#RUN chown -R gurobi ${GUROBI_HOME} && \ 
#chmod 755 ${GUROBI_HOME}/bin/docker-entrypoint.sh

RUN chmod 777 /opt/gurobi/linux64/bin/docker-entrypoint.sh 
#    && ln -s ./docker-entrypoint.sh    


#RUN chmod 777  docker-entrypoint.sh
#${GUROBI_HOME}/bin/docker-entrypoint.sh
#USER gurobi

#WORKDIR /usr/src/gurobi/scripts
WORKDIR /opt/gurobi/linux64/bin
VOLUME /usr/src/gurobi/scripts
VOLUME /home

#USER gurobi

ENTRYPOINT ["docker-entrypoint.sh"]
#CMD ["/bin/bash"]

#sudo docker run -e 'GUROBI_LICENSE=541a93a0-fca3-11e8-9f3c-02e454ff9c50' -v /license:/opt/gurobi/license.lic  --network 'host' gurobi
