#!/bin/bash
sed -i s/"<terminals>${1}<"/"<terminals>${2}<"/g ./config/_1tpcc*;
sed -i s/"<terminals>${1}<"/"<terminals>${2}<"/g ./config/_2wiki*;
sed -i s/"<terminals>${1}<"/"<terminals>${2}<"/g ./config/_3ycsb*;
