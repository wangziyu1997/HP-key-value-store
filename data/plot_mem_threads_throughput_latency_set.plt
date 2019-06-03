#!/bin/gnuplot


reset
set output "figure/mem-threads-throughput-latency_set.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set title "Throughput Latency Set" font ",26"
set ylabel "Latency (Milliseconds)" font ",24"
set xlabel "Throughput (rsp/s)" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set xrange[0:*]
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 5


#plot "./memcached/Throughput_Latency_set_threads_number1.dat" u 1:($2) title "T40" w lp lt 1 lw 3 pt 2 ps 1.8 lc rgb '#ff7373'
plot  \
	"./memcached/throughput-latency/Throughput_Latency_set_threads_number1.dat" u 1:($2) title "Threads1" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEB422', \
	"./memcached/throughput-latency/Throughput_Latency_set_threads_number2.dat" u 1:($2) title "Threads2" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF7F00', \
    "./memcached/throughput-latency/Throughput_Latency_set_threads_number3.dat" u 1:($2) title "Threads3" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEEE00', \
	"./memcached/throughput-latency/Throughput_Latency_set_threads_number4.dat" u 1:($2) title "Threads4" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#C0FF3E', \
	"./memcached/throughput-latency/Throughput_Latency_set_threads_number10.dat" u 1:($2) title "Threads10" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#6495ED', \
	"./memcached/throughput-latency/Throughput_Latency_set_threads_number20.dat" u 1:($2) title "Threads20" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#4B0082', \
    "./memcached/throughput-latency/Throughput_Latency_set_threads_number30.dat" u 1:($2) title "Threads30" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#CD3333', \
	"./memcached/throughput-latency/Throughput_Latency_set_threads_number40.dat" u 1:($2) title "Threads40" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#B8860B', \
	"./memcached/throughput-latency/Throughput_Latency_set_threads_number50.dat" u 1:($2) title "Threads50" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#707070', \
	"./memcached/throughput-latency/Throughput_Latency_set_threads_number60.dat" u 1:($2) title "Threads60" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#030303'
