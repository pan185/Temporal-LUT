`include "DEF.sv"
module register_product
(
    input logic clk,    // Clock
    input logic rst_n,  // Asynchronous reset active lo
    input logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]in, // Val to be written to reg
    output logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out // Val read out
);
    logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0] out_;
    genvar i;
    genvar j;
    generate
    for (i = 0; i < `DIM_C; i = i+1) begin
    for (j = 0; j < `DIM_A; j = j+1) begin
    always_ff @(posedge clk or negedge rst_n) begin : proc_1
        if(~rst_n) begin
            out_[i][j] <= 0;
        end else begin
            out_[i][j] <= in[i][j];
        end
    end
    end
    end
    endgenerate

    always_comb begin : proc_2
        out <= out_;
    end

endmodule
