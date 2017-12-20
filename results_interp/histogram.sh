#!/bin/bash

usage() { echo "Usage: $0 [-t <time>]" 1>&2; exit 1; }

while getopts "b:c:i:p:s:t:" o; do
    case "${o}" in
    t)
	    t=${OPTARG}
	    echo "Time is $t"
	    ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


if [ -z "${t}" ]; then
    usage
fi


ext=".res"
filename=$t.stats 
outfile=$t.hist
echo $filename


gnuplot <<- EOF
	set output '$outfile.png';
    set terminal png size 1600, 900 giant font "Helvetica" 16
    #set tmargin 3;
    #set bmargin 3;
	set datafile separator ',';
    set grid

    set title "Placement per container configuration\n27 tests, 9 comparisons: all benchmarks, 250 clients, 4, 16, 64 scales, 1800 sec. duration"

    set style data histogram
    set style histogram rowstacked
    set style fill solid border -1
    set boxwidth 0.75

    set xlabel "Different docker storage configurations"
    set ylabel "Amount of times"
    set yrange [0:12]
    set label 1 left at graph 0.225, graph 0.9 sprintf('Latency') tc rgb 'black';
    set label 2 left at graph 0.725, graph 0.9 sprintf('Throughput') tc rgb 'black';


    #set style histogram clustered gap 1 title offset 2,0.25
    #set style fill solid noborder	
    #set xtics rotate out
    #set style fill solid border
    #set style histogram gap 5
    #set style histogram columnstacked
    #set style histogram clustered
    plot for [COL=2:5] '1800.stats-final-tot' using COL:xticlabels(1) title columnheader
 
EOF
