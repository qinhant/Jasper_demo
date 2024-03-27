# Introduction
### This repo shows how to use cadence jaspergold to verify a fifo module, including both SVA properties and information flow properties.

# Run
### Either use `jaspergold verify.tcl` or run `jaspergold` first, and in the terminal of jaspergold run `source verify.tcl`.
### The first two assertions are wriiten in SVA and the last two assertions are information flow properties.
### A SVA assertion is true iff. the expression always holds at anytime, while an information flow property is true iff. there is no information flow from source to destination.
### If a property is violated, a counterexample will be provided. Double click on it to see its waveform.