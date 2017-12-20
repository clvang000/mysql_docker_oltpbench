#!/bin/bash
sed -i s/"<time>${1}<"/"<time>${2}<"/g ./config/_1tpcc*;
sed -i s/"<time>${1}<"/"<time>${2}<"/g ./config/_2wiki*;
sed -i s/"<time>${1}<"/"<time>${2}<"/g ./config/_3ycsb*;
