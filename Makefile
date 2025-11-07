# Simulator
SIM = icarus

# Design files
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = design.v
TOPLEVEL = traffic_light_fsm

# Python test file
MODULE = test_fsm

# Cocotb
include $(shell cocotb-config --makefiles)/Makefile.sim
