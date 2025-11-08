module traffic_light_fsm(clk, rst, light); 
    input wire clk; // clock input
    input wire rst; // active-high reset input
    output reg [2:0] light; // 3-bit output representing visible color
    reg [1:0] state; // 2-bit internal register to hold state value
    reg [63:0] timer;  // cycle timer counter
    parameter CLK_HZ = 100_000_000; // safe default
    `ifdef SIMULATION 
    parameter CLK_FREQ = 1; // faster sim
    `else 
    parameter CLK_FREQ = CLK_HZ; // real hardware
    `endif

    localparam [63:0] // time durations in clock cycles
    RED_TIME       = 60  * CLK_FREQ, // ~60s
    RED_AMBER_TIME = 2   * CLK_FREQ, // ~2s
    GREEN_TIME     = 50  * CLK_FREQ, // ~50s
    AMBER_TIME     = 3   * CLK_FREQ; // ~3s

    localparam [1:0] // state encoding
    RED = 2'd0, // b00
    RED_AMBER = 2'd1, // b01
    GREEN = 2'd2, // b10
    AMBER = 2'd3; // b11

    always @(posedge clk) begin // sequential block
        if (rst) begin // if reset is asserted
            state <= RED; // reset to initial state
            timer <= 0; // reset to initial timer
        end else begin
            timer <= timer + 1; // increment timer each cycle

            case (state) // state transition logic
                RED:
                    if (timer >= RED_TIME) begin
                        state <= RED_AMBER; // transition after RED_TIME cycles (timer counts 0→59)
                        timer <= 0; // reset timer for next state
                    end
                RED_AMBER:
                    if (timer >= RED_AMBER_TIME) begin
                        state <= GREEN; // transition after RED_AMBER_TIME cycles (timer counts 0→1)
                        timer <= 0; // reset timer for next state
                    end
                GREEN:
                    if (timer >= GREEN_TIME) begin
                        state <= AMBER; // transition after GREEN_TIME cycles (timer 0→49)
                        timer <= 0; // reset timer for next state
                    end
                AMBER:
                    if (timer >= AMBER_TIME) begin
                        state <= RED; // transition after AMBER_TIME cycles (timer 0→2)
                        timer <= 0; // reset timer for next state
                    end
                default: begin
                    state <= RED; // safety (invalid state)
                    timer <= 0;
                end
            endcase
        end
    end


 always @(*) begin // combinational block
    case (state) // decode state to light output
        RED: light = 3'b100; // red on (d4)
        RED_AMBER: light = 3'b110; // red amber on (d4, d3)
        GREEN: light = 3'b001; // green on (d1)
        AMBER: light = 3'b010; // amber on (d3)
        default: light = 3'b100; // safety (invalid state)
    endcase
end

endmodule 
