#FROM ubuntu:17.10
# Run with e.g.: $ docker build -t maui_simulator .
# Change to your user name (using "userx" in example)
FROM debian:stretch
MAINTAINER Georg Zitzlsberger <georg.zitzlsberger@vsb.cz>
WORKDIR /maui_simulator

RUN apt-get update

# From INSTALL file (PBSPro)
RUN apt-get install -y \
         gcc make libtool libhwloc-dev libx11-dev \
         libxt-dev libedit-dev libical-dev ncurses-dev \
         postgresql-server-dev-all python-dev tcl-dev tk-dev swig \
         libexpat-dev libssl-dev libxext-dev libxft-dev autoconf \
         automake

RUN apt-get install -y \
         expat libedit2 postgresql python sendmail-bin \
         sudo tcl tk vim

# Other stuff
RUN apt-get install -y \
        git

# PBS (not used for the simulation but needed for building Maui)
RUN git clone https://github.com/PBSPro/pbspro.git && \
        cd pbspro && \
        git checkout tags/v18.1.2 && \
        ./autogen.sh && \
        ./configure --prefix=/opt/pbs --with-database-user=userx && \
        make install -j 4 && \
        cp ./src/include/pbs_internal.h /opt/pbs/include && \
        sed -i 's/^[^#].*//g' /opt/pbs/include/pbs_internal.h && \
        sed -i '/#include/c\' /opt/pbs/include/pbs_internal.h && \
        sed -i 's/\/\*.*//g' /opt/pbs/include/pbs_internal.h && \
        sed -i 's/`hostname.*`/localhost/' /opt/pbs/libexec/pbs_postinstall && \
        /opt/pbs/libexec/pbs_postinstall && \
        sed -i '/PBS_START_MOM=0/c\PBS_START_MOM=1' /etc/pbs.conf && \
        chmod 4755 /opt/pbs/sbin/pbs_iff /opt/pbs/sbin/pbs_rcp

# Maui (there are no tags, so using commit ID for pinning)
COPY maui.diff .

#RUN git clone https://github.com/LabAdvComp/maui.git && \
RUN git clone https://github.com/It4innovations/maui.git && \
        cd maui && \
#        git checkout 59e2063 && \ # Is only valid for the original code base from LabAdvComp
        patch -p1 < ../maui.diff && \
        ./configure --with-pbs=/opt/pbs && \
        make install -j 4

# Setup user
RUN useradd -ms /bin/bash userx
RUN chown -R userx:userx /var/run/postgresql/
RUN echo "export LD_LIBRARY_PATH=/opt/pbs/lib" >> /home/userx/.profile && \
        echo "export PATH=$PATH:/usr/local/maui/bin" >> /home/userx/.profile && \
        echo "source /etc/profile.d/pbs.sh" >> /home/userx/.profile

RUN rm /usr/local/maui/maui.cfg && \
        ln -s /home/userx/workdir/maui.cfg /usr/local/maui/maui.cfg

CMD sudo -i -u userx
