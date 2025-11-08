import cocotb
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_fsm_sequence(dut):
    dut.clk.value = 0 # start clock low
    dut.rst.value = 1 # assert reset
    await Timer(5, units="ns") # wait 5ns for reset duration
    dut.rst.value = 0 # deassert reset to start fsm

    expected_sequence = [0b100, 0b110, 0b001, 0b010, 0b100] # array with red, red_amber, green, and amber in binary
    for i, expected in enumerate(expected_sequence): # for loop to verify fsm output
        dut.clk.value = 1 # rising edge
        await Timer(5, units="ns") # wait 5ns
        dut.clk.value = 0 # falling edge
        await Timer(5, units="ns") # wait 5ns 
        assert int(dut.light.value) == expected, f"Step {i}: expected {expected:03b}, got {int(dut.light.value):03b}" # compare output values (decimal -> binary)
        dut._log.info(f"Cycle {i}: light = {int(dut.light.value):03b}") # print debug log info

