module traffic_light(clk, rst, light); 
    parameter RED=0, GREEN=1, YELLOW=2; // symbolic names for readability
    input wire clk; // clock input
    input wire rst; // active-high reset input
    output reg [1:0] light; // 2-bit output representing visible color
    reg [1:0] state; // 2-bit internal register to hold state value

 always @(posedge clk) begin // sequential block: updates on every clock cycle
    if (rst) begin // non-blocking assignment
        state <= RED; // reset to initial state
    end
    
    else begin
        case (state) // non-blocking assignment
        RED: state <= GREEN; // move to green after red
        GREEN: state <= YELLOW; // move to yellow after green
        YELLOW: state <= RED; // move to red after yellow
        endcase
    end
 end 

 always @(*) begin // combinational block: drives output based on state
    light = state; // blocking assingment 
end

endmodule 
