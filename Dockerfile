FROM ubuntu
LABEL maintainer="PH"

RUN apt-get update && apt-get install -q -y libxrender1 libxext6 libxtst6 libxi6 libjavafxsvg-java && apt-get clean
RUN useradd -p devops -m -U devops

WORKDIR /home/devops

COPY ./pacote/dataModelerOracle.tar.gz /home/devops
COPY ./pacote/jdk-8u221-linux-x64.tar.gz /home/devops
RUN tar -xzvf dataModelerOracle.tar.gz -C / && rm -rf dataModelerOracle.tar.gz
RUN tar -xzvf jdk-8u221-linux-x64.tar.gz -C / && rm -rf jdk-8u221-linux-x64.tar.gz
RUN chown -R devops:devops /jdk1.8.0_221

RUN mkdir /home/devops/models
RUN chown -R devops:devops /home/devops/models
RUN chown -R devops:devops /opt/datamodeler/datamodeler/types

USER devops

ENV JAVA_HOME /jdk1.8.0_221
ENV PATH $PATH:$JAVA_HOME/bin

ENTRYPOINT ["bash"]