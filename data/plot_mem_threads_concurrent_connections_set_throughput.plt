#!/bin/gnuplot


reset
set output "figure/CC_throughput_set.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set title "Concurrent Connections Throughput set"
set ylabel "Throughput (rsp/s)" font ",24"
set xlabel "Concurrent Connections" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 5
set yrange[*:300000]

#plot "./memcached/Throughput_Throughput_set_threads_number1.dat" u 1:($2) title "T40" w lp lt 1 lw 3 pt 2 ps 1.8 lc rgb '#ff7373'
plot  \
	"./memcached/concurrent_connections/CC_Throughput_set_threads_number1_throughput.dat" u 1:($2) title "Threads1" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEB422', \
	"./memcached/concurrent_connections/CC_Throughput_set_threads_number2_throughput.dat" u 1:($2) title "Threads2" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF7F00', \
    "./memcached/concurrent_connections/CC_Throughput_set_threads_number3_throughput.dat" u 1:($2) title "Threads3" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEEE00', \
	"./memcached/concurrent_connections/CC_Throughput_set_threads_number4_throughput.dat" u 1:($2) title "Threads4" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#C0FF3E', \
	"./memcached/concurrent_connections/CC_Throughput_set_threads_number10_throughput.dat" u 1:($2) title "Threads10" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#6495ED', \
	"./memcached/concurrent_connections/CC_Throughput_set_threads_number20_throughput.dat" u 1:($2) title "Threads20" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#4B0082', \
    "./memcached/concurrent_connections/CC_Throughput_set_threads_number30_throughput.dat" u 1:($2) title "Threads30" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#CD3333', \
	"./memcached/concurrent_connections/CC_Throughput_set_threads_number40_throughput.dat" u 1:($2) title "Threads40" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#B8860B', \
	"./memcached/concurrent_connections/CC_Throughput_set_threads_number50_throughput.dat" u 1:($2) title "Threads50" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#707070', \
	"./memcached/concurrent_connections/CC_Throughput_set_threads_number60_throughput.dat" u 1:($2) title "Threads60" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#030303'
