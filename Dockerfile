FROM oraclelinux:8

ARG runfile=dragen-4.3.6-11.multi.el8.x86_64.run

RUN dnf install unzip wget -y

#RUN yum install R-base -y
#RUN yum install epel-release -y
#RUN yum install parallel sysvinit-tools gdb rsync smartmontools sos time -y 
#RUN yum install awk dirname grep md5sum rpm sort tr logger sed -y
RUN dnf install which -y
RUN dnf config-manager --enable ol8_codeready_builder
RUN dnf install oracle-epel-release-el8 -y
RUN dnf install R -y
RUN dnf install bc dkms gdb rsync smartmontools sos time -y
RUN dnf install kernel kernel-devel -y
RUN dnf install hostname -y
RUN dnf install perl -y

# /bin/sh dragen-4.0.3-8.el7.x86_64.run 
# returns an error, so use ; instead of &&
# Also note the entire set of commands needs to return 0
# else the Docker build will fail,
# so make sure to keep the rm -rf /dragen_software command 
# or some other command returning 0
# https://webdata.illumina.com/downloads/software/dragen/dragen-4.0.3-8.el8.x86_64.run

# Fake out the preflight check for kernel version/kernel-devel package match
COPY fake_uname/uname /usr/bin/uname

# Method 1: Download within the container
# RUN wget -O $runfile https://webdata.illumina.com/downloads/software/dragen/$runfile && \
#   /bin/sh $runfile; \
#   rm -rf $runfile && \
#   rm -rf /dragen_software

# Method 2: Use local download under runfile/
COPY runfile/$runfile /
# Have to fake out the Docker build to think RUN returned without error
RUN /bin/sh $runfile; \
  rm -rf $runfile && \
  rm -rf /dragen_software
