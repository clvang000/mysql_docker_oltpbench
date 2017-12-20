#!/bin/bash
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale1.xml --create=true --load=true;
./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale4.xml --create=true --load=true;
./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale16.xml --create=true --load=true;
./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale64.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale1.xml --create=true --load=true;
./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale4.xml --create=true --load=true;
./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale16.xml --create=true --load=true;
./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale64.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale1.xml --create=true --load=true;
./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale4.xml --create=true --load=true;
./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale16.xml --create=true --load=true;
./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale64.xml --create=true --load=true;

#sleep 10;
#bash _0portchange.sh 3306 6603;
#sleep 10;
#
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale1.xml --create=true --load=true;
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale4.xml --create=true --load=true;
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale16.xml --create=true --load=true;
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale64.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale1.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale4.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale16.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale64.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale1.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale4.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale16.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale64.xml --create=true --load=true;
#
#sleep 10;
#bash _0portchange.sh 6603 6604;
#sleep 10;
#
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale1.xml --create=true --load=true;
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale4.xml --create=true --load=true;
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale16.xml --create=true --load=true;
#./oltpbenchmark --bench tpcc --config ./config/_1tpcc_scale64.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale1.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale4.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale16.xml --create=true --load=true;
#./oltpbenchmark --bench wikipedia --config ./config/_2wiki_scale64.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale1.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale4.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale16.xml --create=true --load=true;
#./oltpbenchmark --bench ycsb --config ./config/_3ycsb_scale64.xml --create=true --load=true;
