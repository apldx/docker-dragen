docker-dragen
=============


Resources
---------

https://www.illumina.com/products/by-type/informatics-products/dragen-bio-it-platform.html

Dragen home page

https://support.illumina.com/sequencing/sequencing_software/dragen-bio-it-platform/downloads.html

Dragen software downloads


Build
-----

To build a different version, see `Versions` below.

Download Dragen software 3.8.4 (Centos 7) from 

https://support.illumina.com/sequencing/sequencing_software/dragen-bio-it-platform/downloads.html

When you click on the download link a signed URL that can be used on the
command line will be provided. This link should replace `URL` in `Dockerfile`
in the line

    RUN wget -O dragen-3.8.4-7.el7.x86_64.zip 'URL' && \

Build the Docker image. The R build can take so long that the signed
link will expire; if so, get a new signed link and the build will start
where it left off and the link should work.

    # You will see errors because the Dragen package is 
    # being installed away from the Dragen itself. It will still work.
    make build

Launch an interactive shell

    make interact

push to DockerHub (be sure to modify `Makefile` to use your own account)

    make push


Versions
--------

Be sure to get the Centos 7 version of whatever Dragen version you are
downloading (as of 3.8.x, this is the only option).

The build instructions are for version `3.8.4`, the latest version as of
`20210707`. To use a different version, change the version number in the
`Makefile` from 

    VERSION := 3.8.4

to match the version in the name of the zip file. For example, version
`3.7.5` should be set to 

    VERSION := 3.7.5

This is necessary for correct Docker image tagging. Essential is to
change the commands in the `Dockerfile` to match the downloaded
filename. For example, `3.7.5` has a zip file named

    dragen-3.7.5-4.el7.x86_64.zip

So the following should be all be changed from 

    wget -O dragen-3.8.4-7.el7.x86_64.zip
    ...
    unzip dragen-3.8.4-7.el7.x86_64.zip && \
    rm -f dragen-3.8.4-7.el7.x86_64.zip && \
    /bin/sh dragen-3.8.4-7.el7.x86_64.run; \

to

    wget -O dragen-3.7.5-4.el7.x86_64.zip
    ...
    unzip dragen-3.7.5-4.el7.x86_64.zip && \
    rm -f dragen-3.7.5-4.el7.x86_64.zip && \
    /bin/sh dragen-3.7.5-4.el7.x86_64.run; \


Usage
-----

Dragen software is installed under `/opt/edico`.

The `dragen` binary 

    /opt/edico/bin/dragen

when run with no arguments will print a help message, but note 
that if run away from the Dragen hardware it will result in a driver
error instead.


A note on Dockerfile installs
-----------------------------

The image is large, in part because of the requirements installed in the
Docker image. I tried to come up with a minimal set for a successful
build of `3.7.5` by letting the Dragen install fail on missing packages
and adding them one by one. This set continues to work for `3.8.4`.



