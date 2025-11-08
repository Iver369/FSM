module traffic_light_fsm(clk, rst, light); 
    input wire clk; // clock input
    input wire rst; // active-high reset input
    output reg [2:0] light; // 3-bit output representing visible color
    reg [1:0] state; // 2-bit internal register to hold state value
    localparam [1:0] // symbolic names for readability with local parameters
    RED = 2'd0, // b00
    RED_AMBER = 2'd1, // b01
    GREEN = 2'd2, // b10
    AMBER = 2'd3; // b11

 always @(posedge clk) begin // sequential block: updates on every clock cycle
    if (rst) begin // non-blocking assignment
        state <= RED; // reset to initial state
    end
    
    else begin
        case (state) // non-blocking assignment
        RED: state <= RED_AMBER; // move to red-amber after red
        RED_AMBER: state <= GREEN; // move to green after red-amber
        GREEN: state <= AMBER; // move to amber after green
        AMBER: state <= RED; // returns to red on next clock tick
        default: state <= RED; // safety (invalid state)
        endcase
    end
 end 

 always @(*) begin // combinational block: drives output based on state
    case (state) // blocking assignment
        RED: light = 3'b100; // red on (d4)
        RED_AMBER: light = 3'b110; // red amber on (d4, d3)
        GREEN: light = 3'b001; // green on (d1)
        AMBER: light = 3'b010; // amber on (d3)
        default: light = 3'b100; // safety (invalid state)
    endcase
end

endmodule 
