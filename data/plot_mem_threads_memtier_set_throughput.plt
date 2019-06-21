#!/bin/gnuplot


reset
set output "figure/memcached/memtier_Throughput_set.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set title "Memtier-benchmark Throughput Set"
set ylabel "Throughput (rsp/s)" font ",24"
set xlabel "Memtier-benchmark threads" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 5
set xrange[1:*]


plot  \
	"./memcached/network_model_memtier/tl/1thread.dat" u 1:($3) title "Threads1" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEB422', \
	"./memcached/network_model_memtier/tl/2thread.dat" u 1:($3) title "Threads2" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#FF7F00', \
    "./memcached/network_model_memtier/tl/3thread.dat" u 1:($3) title "Threads3" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#EEEE00', \
	"./memcached/network_model_memtier/tl/4thread.dat" u 1:($3) title "Threads4" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#C0FF3E', \
	"./memcached/network_model_memtier/tl/10thread.dat" u 1:($3) title "Threads10" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#6495ED', \
	"./memcached/network_model_memtier/tl/20thread.dat" u 1:($3) title "Threads20" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#4B0082', \
    "./memcached/network_model_memtier/tl/30thread.dat" u 1:($3) title "Threads30" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#CD3333', \
	"./memcached/network_model_memtier/tl/40thread.dat" u 1:($3) title "Threads40" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#B8860B', \
	"./memcached/network_model_memtier/tl/50thread.dat" u 1:($3) title "Threads50" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#707070', \
	"./memcached/network_model_memtier/tl/60thread.dat" u 1:($3) title "Threads60" w lp lt 3 lw 3 pt 7 ps 1.5 lc rgb '#030303'
