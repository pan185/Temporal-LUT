`include "DEF.sv"
module rollover_cnt 
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active low
    input logic enable,
    output logic [`INPUT_WIDTH-1:0]cntOut,
    output logic rollover
);

    logic [`INPUT_WIDTH-1:0]cnt;
    //logic rollover_;

    always_ff @(posedge clk or negedge rst_n) begin : proc_1
        if(~rst_n) begin
            cnt <= 0;
        end else begin
            cnt <= cnt + enable;
        end
    end

    always_comb begin : proc_2
        // grayOut <= (cnt>>1) ^ cnt;
        cntOut <= cnt;
	rollover = (cnt=='0)&enable;
    end

endmodule
