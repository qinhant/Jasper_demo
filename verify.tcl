analyze -sv fifo.v

elaborate -top fifo

clock clk
reset rst

#assertion to check fifo will not overflow (##1 means after 1 cycle, $stable is true if the signal's value is the same as last cycle)
assert {fifo_full && push && !pop |-> ##1 $stable(fifo_counter)} 

#assertion to check the fifo size cannot exceed 4 (double click the counterexample to see the execution trace)
assert {fifo_counter <= 4}   

#IFT properties of SPV (source to destination)
check_spv -create -from fifo_in -to fifo_counter
check_spv -create -from pop -to fifo_counter

prove -all

