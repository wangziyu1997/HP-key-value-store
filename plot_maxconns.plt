#!/bin/gnuplot


reset
set output "figure/maxconns.eps"
set term postscript "Helvetica" eps enhance dl 2 color

set pointsize 0.8
set size 1.0,1.0

set title "maxconns" font ",26"
set ylabel "Throughput (rsp/s)" font ",24"
set xlabel "Number of maxconns" font ",24"

set ytics nomirror font ",20"
set xtics nomirror font ",20"

set mxtics 2
#set logscale y
set xrange[0:*]
set key top left
set key samplen 1.8 spacing 1 width 1 height 0.5 font ",20" maxrows 2


plot "./plot_data/maxconns.dat" u 1:($2) title "maxconns" w lp lt 1 lw 3 pt 2 ps 1.8 lc rgb '#ff7373'
