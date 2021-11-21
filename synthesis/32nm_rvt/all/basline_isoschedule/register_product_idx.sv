`include "DEF.sv"
module register_product_idx
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active lo
    input logic enable,
    //input logic [clogb2(`DIM_A)-1:0] idx, //TODO:
    input logic [2:0] idx, //TODO
    input logic [`ACC_WIDTH-1:0]in, // Val to be written to reg
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out // Val read out
);
    logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] out_;
    
    always_ff @(posedge clk or negedge rst_n) begin : proc_1
        if(~rst_n) begin
            out_ <= 0;
        end else if (enable) begin
            //PRAJYOTG :: updated out_[idx] <=in
            // TODO :: value hard-coded to only 1 weight
            out_[0][idx] <= in;
        end
    end

    always_comb begin : proc_2
        out <= out_;
    end

endmodule
