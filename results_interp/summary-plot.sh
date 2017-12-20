#!/bin/bash

usage() { echo "Usage: $0 [-b <benchmark>] [-c <clients>] [-i <interval>] [-s <scale>] [-t <time>]" 1>&2; exit 1; }

gnuplot <<- EOF
    #### General Settings
    
	set output 'tpcc-summary.png';
	set terminal png size 1600, 900;
    #set multiplot layout 3,1 title '$b, scale $s, clients $c' font ',18';
    set tmargin 3;
    set bmargin 3;
	set datafile separator ',';
    set grid
	
    set xrange[0:$t];
	set x2range[0:$t];


	### Plot 1 

    set title "native" font ",16" offset 0,-0.5;

    set xtics scale 1,1
    set xlabel 'Clients (s)'; 
    set ylabel 'Mean latency (ms)';

    plot \
        'stats_tpcc-4-native.txt' using 1:2 with lines title 'Native' lt rgb 'red',\
        'stats_tpcc-4-bind.txt' using 1:2 with lines title 'Bind' lt rgb 'blue',\
        'stats_tpcc-4-volume.txt' using 1:2 with lines title 'Volume' lt rgb 'green';\


EOF
