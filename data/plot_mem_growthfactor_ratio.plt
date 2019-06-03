#!/bin/gnuplot


reset
set output "figure/growth_factor_ratio.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set title "Growth Factor Ratio"
set ylabel "Utilization Ratio" font ",24"
set xlabel "Growth Factor" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 5


#plot "./memcached/Throughput_Latency_get_threads_number1.dat" u 1:($2) title "T40" w lp lt 1 lw 3 pt 2 ps 1.8 lc rgb '#ff7373'
plot  \
	"./memcached/bytes/bytes100.dat" u 1:($2/67108864) title "100 bytes" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEB422', \
	"./memcached/bytes/bytes1000.dat" u 1:($2/67108864) title "1000 bytes" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF7F00', \
    "./memcached/bytes/bytes10000.dat" u 1:($2/67108864) title "10000 bytes" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEEE00'