#!/bin/bash

#========== INFO ============

# this script will run all tests, with a CONSTANT port, CONSTANT number of clients, and CONSTANT runtime
# the only thing that fluctuates is the scalefactor (and benchmark)

# ARG_1 (port)        = 3306 | 6603 | 6604      	(USED to determine what to restart)
# ARG_2 (#clients)    = specified in _3execAll.sh	(ONLY used for result file name) 
# ARG_3 (runtime)     = in seconds              	(ONLY used for result file name)

# file name spec     = <benchmark>_<port>_<scale>_<#clients>_<runtime>

sample_size=5

#========== CODE ============

#TPCC (4 different scalefactors)
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale1.xml --execute=true --sample 1 --output tpcc_${1}_sc1_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale4.xml --execute=true --sample ${sample_size} --output tpcc_${1}_sc4_cl${2}_rt${3};
sh _0restartSQL.sh ${1};
./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale16.xml --execute=true --sample ${sample_size} --output tpcc_${1}_sc16_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale64.xml --execute=true --sample ${sample_size} --output tpcc_${1}_sc64_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};

#WIKIPEDIA (4 different scalefactors)
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale1.xml --execute=true --sample 1 --output wiki_${1}_sc1_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale4.xml --execute=true --sample ${sample_size} --output wiki_${1}_sc4_cl${2}_rt${3};
sh _0restartSQL.sh ${1};
./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale16.xml --execute=true --sample ${sample_size} --output wiki_${1}_sc16_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale64.xml --execute=true --sample ${sample_size} --output wiki_${1}_sc64_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};

#YCSB (4 different scalefactors)
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale1.xml --execute=true --sample 1 --output ycsb_${1}_sc1_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale4.xml --execute=true --sample ${sample_size} --output ycsb_${1}_sc4_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};
./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale16.xml --execute=true --sample ${sample_size} --output ycsb_${1}_sc16_cl${2}_rt${3};
sh _0restartSQL.sh ${1};
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale64.xml --execute=true --sample ${sample_size} --output ycsb_${1}_sc64_cl${2}_rt${3};
#sh _0restartSQL.sh ${1};
