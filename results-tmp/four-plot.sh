#!/bin/bash

usage() { echo "Usage: $0 [-b <benchmark>] [-c <clients>] [-i <interval>] [-s <scale>] [-t <time>]" 1>&2; exit 1; }

while getopts "b:c:i:p:s:t:" o; do
    case "${o}" in
    b)
        b=${OPTARG}
        echo "Benchmark is $b"
        ;; 
    c)
        c=${OPTARG}
	    echo "Clients are $c"
        ;;
    i)  
        i=${OPTARG}
        echo "Interval is $i"
        ;;
	s)  
	    s=${OPTARG} 
	    echo "Scale is $s"
	    ;;
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


if [ -z "${b}" ] || [ -z "${c}" ] || [ -z "${i}" ] || [ -z "${s}" ]; then
    usage
fi


ext=".res"
#filename=res_fulltest_600/$b\_$p\_sc$s\_cl$c\_rt$t$ext
filename1=res_fulltest_600/$b\_3306_sc$s\_cl$c\_rt$t$ext
filename2=res_fulltest_600/$b\_6603_sc$s\_cl$c\_rt$t$ext
filename3=res_fulltest_600/$b\_6604_sc$s\_cl$c\_rt$t$ext
filename4=res_fulltest_600/$b\_6605_sc$s\_cl$c\_rt$t$ext
outfile=4p_$b\_sc$s\_cl$c\_rt$t
echo $filename


gnuplot <<- EOF
    #### General Settings
    
	set output '$outfile.png';
	set terminal png size 1600, 1200;
    set multiplot layout 4,1 title '$b, scale $s, clients $c' font ',18';
    set tmargin 3;
    set bmargin 3;
	set datafile separator ',';
    set grid
	
    set xrange[0:$t];
	set x2range[0:$t];


	### Plot 1 

    set title "native" font ",16" offset 0,-0.5;

    stats '$filename1' using 2 name 'tp';
    stats '$filename1' using 3 name 'lt';

    set label 1 left at graph 0.025, graph 1.1 sprintf('Mean latency: %f', lt_mean) tc rgb 'blue';
    set label 2 left at graph 0.225, graph 1.1  sprintf('Std latency: %f', lt_stddev) tc rgb 'blue';
    set label 3 right at graph 0.775, graph 1.1  sprintf('Mean throughput: %f', tp_mean) tc rgb 'red';
    set label 4 right at graph 0.975, graph 1.1  sprintf('Std throughput: %f', tp_stddev) tc rgb 'red';
    set xtics scale 1,1
    set xlabel 'Time (s)'; 
    set ylabel 'Latency (ms)';
    set y2label 'Throughput (req/s)';

    set ytics nomirror;
    set y2tics;
  
    set print "stats_$b-$c-$s-$t.txt"
    print "Method, Mean Latency, Std. Latency, Mean Throughput, Std. Throughput"
    print "native ",  lt_mean, ", ", lt_stddev, ", ", tp_mean, ", ", tp_stddev
    set print

    plot \
        '$filename1' using (\$0*$i):2 with lines title 'Throughput (req/s)' lt rgb 'red' axes x1y2,\
        '$filename1' using (\$0*$i):3 with lines title 'Mean latency (ms)' lt rgb 'blue axes x1y1';\


    ### Plot 2

    set title "bind";
     
    stats '$filename2' using 2 name 'tp';
    stats '$filename2' using 3 name 'lt';
    
    set print "stats_$b-$c-$s-$t.txt" append
    print "bind, ",  lt_mean, ", ", lt_stddev, ", ", tp_mean, ", ", tp_stddev
    set print
 
    set label 1 left at graph 0.025, graph 1.1 sprintf('Mean latency: %f', lt_mean) tc rgb 'blue';
    set label 2 left at graph 0.225, graph 1.1  sprintf('Std latency: %f', lt_stddev) tc rgb 'blue';
    set label 3 right at graph 0.775, graph 1.1  sprintf('Mean throughput: %f', tp_mean) tc rgb 'red';
    set label 4 right at graph 0.975, graph 1.1  sprintf('Std throughput: %f', tp_stddev) tc rgb 'red';

    plot \
        '$filename2' using (\$0*$i):2 with lines title 'Throughput (req/s)' lt rgb 'red' axes x1y2,\
        '$filename2' using (\$0*$i):3 with lines title 'Mean latency (ms)' lt rgb 'blue axes x1y1';\


    ### Plot 3

    set title "volume";

    stats '$filename3' using 2 name 'tp';
    stats '$filename3' using 3 name 'lt';
    
    set print "stats_$b-$c-$s-$t.txt" append
    print "volume, ",  lt_mean, ", ", lt_stddev, ", ", tp_mean, ", ", tp_stddev
    set print

    set label 1 left at graph 0.025, graph 1.1 sprintf('Mean latency: %f', lt_mean) tc rgb 'blue';
    set label 2 left at graph 0.225, graph 1.1  sprintf('Std latency: %f', lt_stddev) tc rgb 'blue';
    set label 3 right at graph 0.775, graph 1.1  sprintf('Mean throughput: %f', tp_mean) tc rgb 'red';
    set label 4 right at graph 0.975, graph 1.1  sprintf('Std throughput: %f', tp_stddev) tc rgb 'red';

    set xlabel 'Time (s)';
    plot \
        '$filename3' using (\$0*$i):2 with lines title 'Throughput (req/s)' lt rgb 'red' axes x1y2,\
        '$filename3' using (\$0*$i):3 with lines title 'Mean latency (ms)' lt rgb 'blue axes x1y1';\


    ### Plot 4

    set title "container";

    stats '$filename4' using 2 name 'tp';
    stats '$filename4' using 3 name 'lt';
    
    set print "stats_$b-$c-$s-$t.txt" append
    print "volume, ",  lt_mean, ", ", lt_stddev, ", ", tp_mean, ", ", tp_stddev
    set print

    set label 1 left at graph 0.025, graph 1.1 sprintf('Mean latency: %f', lt_mean) tc rgb 'blue';
    set label 2 left at graph 0.225, graph 1.1  sprintf('Std latency: %f', lt_stddev) tc rgb 'blue';
    set label 3 right at graph 0.775, graph 1.1  sprintf('Mean throughput: %f', tp_mean) tc rgb 'red';
    set label 4 right at graph 0.975, graph 1.1  sprintf('Std throughput: %f', tp_stddev) tc rgb 'red';

    set xlabel 'Time (s)';
    plot \
        '$filename4' using (\$0*$i):2 with lines title 'Throughput (req/s)' lt rgb 'red' axes x1y2,\
        '$filename4' using (\$0*$i):3 with lines title 'Mean latency (ms)' lt rgb 'blue axes x1y1';\

#	set yrange[0:];
#	set y2range[0:];
#	set xlabel 'Time (s)';
#	set ylabel 'Latency (ms)';
#	set y2label 'Throughput (req/s)';
#	stats '$filename' using 2 name 'tp';
#	stats '$filename' using 3 name 'lt';
#	latency_mean = lt_mean;
	unset multiplot;
EOF
