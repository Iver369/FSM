# Verilog (design.v)
3-state Finite State Machine (FSM) that models a traffic light   
Cycles through RED → GREEN → YELLOW sequence on every rising clock edge. 

# Python (test_fsm.py)
Cobot test-bench that verifies the FSM cycles.  
The FSM has three output states: RED = 0 GREEN = 1 YELLOW = 2  

The tests performs the following steps:  
\- Runs a 10ns clock on the clk input  
\- Asserts reset, waits a few clock cycles, and checks that the FSM starts in the RED state  
\- On each rising edge of the clock, the test reads the current output and verifies that the FSM moves to the correct next state. 

# Tools
RTL Design: Verilog  
Verification: Python 3, cocotb  
Simulation: Icarus Verilog (open-source simulator)  
Waveform Viewing: GTKWave  
Build Automation: make  
Version Control: Git & GitHub. 


