`include "DEF.sv"
module cmp 
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active low
    input logic enable,
    input logic [`INPUT_WIDTH-1:0]rng,
    input logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]in,
    output logic [`DIM_A-1:0]cmp_out
);
    logic [`DIM_A-1:0] cmp_;
    genvar i;
    generate
    for (i=0; i < `DIM_A; i = i+1) begin
    always_ff @(posedge clk or negedge rst_n) begin : proc_1
        if(~rst_n) begin
            cmp_[i] <= 0;
        end else begin
            cmp_[i] <= (in[i] > rng) & enable;
        end
    end
    end
    endgenerate

    always_comb begin : proc_2
        cmp_out <= cmp_;
    end

endmodule