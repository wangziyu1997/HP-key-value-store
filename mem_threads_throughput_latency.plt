#!/bin/gnuplot


reset
set output "figure/mem-threads-throughput-latency.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set title "Threads" font ",26"
set ylabel "Latency (Milliseconds)" font ",24"
set xlabel "Throughput (rsp/s)" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set xrange[0:*]
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 3


#plot "./plot_data/mem_threads40.dat" u 1:($2) title "T40" w lp lt 1 lw 3 pt 2 ps 1.8 lc rgb '#ff7373'
plot  \
	"./plot_data/mem_threads1.dat" u 1:($2) title "Threads1" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF0000', \
	"./plot_data/mem_threads2.dat" u 1:($2) title "Threads2" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF7F00', \
    "./plot_data/mem_threads3.dat" u 1:($2) title "Threads3" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEEE00', \
	"./plot_data/mem_threads4.dat" u 1:($2) title "Threads4" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#C0FF3E', \
	"./plot_data/mem_threads10.dat" u 1:($2) title "Threads10" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#6495ED', \
	"./plot_data/mem_threads20.dat" u 1:($2) title "Threads20" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#4B0082', \
    "./plot_data/mem_threads30.dat" u 1:($2) title "Threads30" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#707070', \
	"./plot_data/mem_threads40.dat" u 1:($2) title "Threads40" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#030303', \
