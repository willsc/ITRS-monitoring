FROM centos:8
ENV container oci
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#CMD ["/bin/sh", "-c", "bash"]

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum update -y && yum install -y openssh-server  libnsl.x86_64 sudo && yum clean all \
    && yum -y install postgresql*   \
    && yum -y install mariadb-connector* 
COPY ./scripts/geneos-gateway-6.4.0-linux-x64.tar /opt/geneos-gateway-6.4.0-linux-x64.tar
RUN tar -xvf /opt/geneos-gateway-6.4.0-linux-x64.tar -C /opt/ 
COPY ./scripts/gateway.sh /opt/gateway/gateway.sh 
COPY ./scripts/wait_for_it.sh /opt/gateway/wait_for_it.sh 
COPY ./scripts/wait_ccprovider.sh /opt/gateway/wait_ccprovider.sh 
COPY ./scripts/wait_hub.sh /opt/gateway/wait_hub.sh 
RUN  mkdir -p /gateway/initial_setup
COPY ./scripts/gateway/initial_setup/gateway.setup.xml /gateway/initial_setup/
COPY ./scripts/gateway /
COPY ./scripts/gateway.gci /gateway/config/gateway.gci 
RUN useradd --system geneos
RUN usermod -a -G root geneos    \
    && mkdir -p /gateway/persist/setup /gateway/persist/data    \
    && chmod a+w /gateway /gateway/persist /gateway/persist/setup /gateway/persist/data    \
    && chmod -R a+r /gateway    \
    && chown -R geneos:geneos /gateway /opt 
USER geneos
WORKDIR /gateway
EXPOSE 7038
EXPOSE 7039
ENTRYPOINT ["/bin/sh", "-c", "/opt/gateway/gateway.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
