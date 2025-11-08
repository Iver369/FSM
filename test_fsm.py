import cocotb
from cocotb.triggers import RisingEdge, Timer
from cocotb.clock import Clock

@cocotb.test()
async def test_fsm_sequence(dut):
    cocotb.start_soon(Clock(dut.clk, 10, unit="ns").start()) # drive clock to tick every 10ns
    dut.rst.value = 1 # assert reset
    await Timer(5, unit="ns") # hold reset for clean initialization
    dut.rst.value = 0 # deassert reset to start fsm
    await RisingEdge(dut.clk) # synchronizes by ensuring dut samples rst=0 exactly on clock edge

    waits = [60, 2, 50, 3] # amount of ticks per state
    expect = [0b100, 0b110, 0b001, 0b010] # array with red, red_amber, green, and amber in binary
    for step, (state_clks, exp) in enumerate(zip(waits, expect)): # for loop to verify fsm output
        for _ in range(state_clks): # loops for the number of clock cycles in each state
            await RisingEdge(dut.clk) # wait for rising edge of clock
        assert int(dut.light.value) == exp # checks if light output matches expected value
        got = int(dut.light.value) # captures value for logging
        dut._log.info(f"state {step}: exp {exp:03b} got {got:03b} {'OK' if got == exp else 'FAIL'}") # log expected vs got values