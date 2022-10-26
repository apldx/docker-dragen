#!/bin/bash

runfile=dragen-4.0.3-8.el8.x86_64.run

rm -rf runfile
mkdir runfile

(cd runfile && wget -O $runfile https://webdata.illumina.com/downloads/software/dragen/$runfile)

