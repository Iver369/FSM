# Verilog (design.v)
4-state Finite State Machine (FSM) that models a traffic light   
Cycles through RED → RED_AMBER → GREEN → AMBER sequence on every rising clock edge  
When reset (`rst`) is asserted high, the FSM returns to the RED state   
The 3-bit output (`light[2:0]`) drives the physical lights (Red, Amber, Green)  

# Python (test_fsm.py)
Cobot test-bench that verifies the FSM cycles  
The FSM has four internal states using 2-bit encoding:   
`RED = 2'd0 (b00)`  
`RED_AMBER = 2'd1 (b01)`  
`GREEN = 2'd2 (b10)`   
`AMBER = 2'd3 (b11)`  

The test performs the following steps:  
\- Runs a 10 ns clock on the `clk` input  
\- Asserts `rst`, waits a few clock cycles, and checks that the FSM starts in the `RED` state  
\- On each rising clock edge, reads the current output and verifies that the FSM moves to the correct next state

# Tools
RTL Design: Verilog  
Verification: Python 3, cocotb  
Simulation: Icarus Verilog (open-source simulator)  
Waveform Viewing: GTKWave  
Build Automation: make  
Version Control: Git & GitHub. 

  
