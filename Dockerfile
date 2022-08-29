FROM centos:7

RUN yum install unzip wget -y

RUN yum install epel-release -y
RUN yum install R -y
RUN yum install parallel sysvinit-tools gdb rsync smartmontools sos time -y 

# /bin/sh dragen-4.0.3-8.el7.x86_64.run 
# returns an error, so use ; instead of &&
# Also note the entire set of commands needs to return 0
# else the Docker build will fail,
# so make sure to keep the rm -rf /dragen_software command 
# or some other command returning 0
RUN wget -O dragen-4.0.3-8.el7.x86_64.run 'https://webdata.illumina.com/downloads/software/dragen/dragen-4.0.3-8.el7.x86_64.run' && \
  /bin/sh dragen-4.0.3-8.el7.x86_64.run; \
  rm -rf dragen-4.0.3-8.el7.x86_64.run && \
  rm -rf /dragen_software
