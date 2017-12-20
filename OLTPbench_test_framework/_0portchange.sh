#!/bin/bash
sed -i s/"$1"/"$2"/g ./config/_1tpcc*;
sed -i s/"$1"/"$2"/g ./config/_2wiki*;
sed -i s/"$1"/"$2"/g ./config/_3ycsb*;
