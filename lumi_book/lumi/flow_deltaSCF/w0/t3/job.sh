#!/bin/bash
cd /Users/jbouquiaux/git/lumi_book/lumi_book/lumi/flow_deltaSCF/w0/t3
# OpenMp Environment
export OMP_NUM_THREADS=1
# Commands before execution
export PATH=/Users/jbouquiaux/git/abinit/build/src/98_main:$PATH

mpirun  -n 2 abinit /Users/jbouquiaux/git/lumi_book/lumi_book/lumi/flow_deltaSCF/w0/t3/run.abi --timelimit 0-1:0:0  > /Users/jbouquiaux/git/lumi_book/lumi_book/lumi/flow_deltaSCF/w0/t3/run.log 2> /Users/jbouquiaux/git/lumi_book/lumi_book/lumi/flow_deltaSCF/w0/t3/run.err