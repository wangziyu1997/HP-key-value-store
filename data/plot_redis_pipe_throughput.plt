#!/bin/gnuplot


reset
set output "figure/redis/pipe_throughput.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set ylabel "Throughput (rsp/s)" font ",24"
set xlabel "Concurrent Connections" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 5
set xrange[1:*]
set yrange[*:2000000]
plot  \
    "./redis/pipe/CC-Throughput_Latency_set_pipe_throughput.dat" u 1:($2) title "set with pipeline" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#6495ED', \
    "./redis/pipe/CC-Throughput_Latency_get_pipe_throughput.dat" u 1:($2) title "get with pipeline" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#CD3333', \
    "./redis/pipe/CC-Throughput_Latency_set_nopipe_throughput.dat" u 1:($2) title "set without pipeline" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#C0FF3E', \
	"./redis/pipe/CC-Throughput_Latency_get_nopipe_throughput.dat" u 1:($2) title "get without pipeline" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF7F00'
    
	