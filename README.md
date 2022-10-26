docker-dragen
=============

Version 4.0.3 for Oracle 8 


Resources
---------

https://www.illumina.com/products/by-type/informatics-products/dragen-bio-it-platform.html

Dragen home page

https://support.illumina.com/sequencing/sequencing_software/dragen-bio-it-platform/downloads.html

Dragen software downloads


Build
-----

Fetch the Dragen software from Illumina

    # Downloads to runfile/
    0/fetch_runfile.sh

Build

    # You will see many errors, but don't worry
    make build

Launch an interactive shell

    make interact

push to DockerHub (be sure to modify `Makefile` to use your own account)

    make push

The `runfile/` directory can be deleted when the build is complete


Usage
-----

Dragen software is installed under `/opt/edico`.

The `dragen` binary 

    /opt/edico/bin/dragen

when run with no arguments will print a help message, but note 
that if run away from the Dragen hardware it will result in a driver
error instead.


Notes
-----

This Oracle 8 image is large (5.41GB compressed) compared to the CentOS
7 version (2.36GB), I'm not sure why and will try to optimize it.

Building under Oracle 8 also required copying in a fake `uname` (see
`fake_uname/uname`) that outputs a kernel version matching the Oracle 8
`kernel-devel` package, otherwise the pre-flight check by the Dragen
software install fails. This is not required under CentOS 7. 

The reason for the kernel mismatch is that `uname` reports the host
kernel. Hopefully things will still work as the kernel and driver on the
Dragen will be from the underlying OS. `dragen` and `dragen_lic` are
able to run and communicate with the dongle but we are still testing



