# Simulator
SIM = icarus

# Automatically enable simulation timing
ifeq ($(SIM),icarus)
  COMPILE_ARGS += -DSIMULATION
endif

# Design files
TOPLEVEL_LANG = verilog
VERILOG_SOURCES = design.v
TOPLEVEL = traffic_light_fsm

# Python test file
MODULE = test_fsm

# Cocotb
include $(shell cocotb-config --makefiles)/Makefile.sim
