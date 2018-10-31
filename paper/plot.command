# set term cairolatex pdf
set terminal pdfcairo font "times,14"
set output "results_rx.pdf"
#set xtics ("rxdrop" 0.75, "txpush" 2.25, "l2fwd" 3.75,)
set xtics ("rxdrop" 1.75)
set ylabel "Mpps"

set boxwidth 0.5
set for [i=1:64] linetype i lw 1 lc rgb "black" pt 7
set style fill pattern 0 border -1
set format x ""

plot [0:3.5][0:90] 'results_rx.data' every 6 using 1:2 with boxes ls 1 title "Baseline", 'results_rx.data' every 6::1 using 1:2 with boxes ls 2 title "XDP ATTACH", 'results_rx.data' every 6::2 using 1:2 with boxes ls 3 title "Remove indirect call in XDP path", 'results_rx.data' every 6::3 using 1:2 with boxes ls 4 title "Replace switch in driver", 'results_rx.data' every 6::4 using 1:2 with boxes ls 5 title "Various driver opts", 'results_rx.data' every 6::5 using 1:2 with boxes ls 6 title "Explicit context in XDP path", "" u 1:2:2 with labels offset char 0,1 title ""

set output "results_tx.pdf"
set xtics ("txpush" 1.5)

plot [0:3][0:140] 'results_tx.data' every 5 using 1:2 with boxes ls 1 title "Baseline", 'results_tx.data' every 5::1 using 1:2 with boxes ls 2 title "Multiple Tx queues", 'results_tx.data' every 5::2 using 1:2 with boxes ls 3 title "Batch size and descriptor ring changes", 'results_tx.data' every 5::3 using 1:2 with boxes ls 4 title "Optimized cleanup not shared with XDP", 'results_tx.data' every 5::4 using 1:2 with boxes ls 5 title "In order completion", "" u 1:2:2 with labels offset char 0,1 title ""

set output "results_poll.pdf"
set xtics ("rxdrop" 0.7, "txpush" 2.3, "l2fwd" 3.8)

plot [0:4.5][0:80] 'results_poll.data' every 2 using 1:2 with boxes ls 1 title "Run-to-completion", 'results_poll.data' every 2::1 using 1:2 with boxes ls 2 title "poll()", "" u 1:2:2 with labels offset char 0,1 title ""

set output "results_dpdk.pdf"
set xtics ("rxdrop" 1.3, "txpush" 3.8, "l2fwd" 6.3)

plot [0:7.5][0:120] 'results_dpdk.data' every 4 using 1:2 with boxes ls 1 title "AF XDP Run-to-completion", 'results_dpdk.data' every 4::1 using 1:2 with boxes ls 2 title "AF XDP poll()", 'results_dpdk.data' every 4::2 using 1:2 with boxes ls 3 title "DPDK scalar driver", 'results_dpdk.data' every 4::3 using 1:2 with boxes ls 4 title "DPDK vectorized driver", "" u 1:2:2 with labels offset char 0,1 title ""
