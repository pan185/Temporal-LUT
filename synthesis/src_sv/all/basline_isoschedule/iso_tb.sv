`include "DEF.sv"
`include "register_input.sv"
`include "register_weight.sv"
`include "register_product.sv"
`include "multiplier.sv"

module iso_tb();

logic clk;  
logic rst_n;
//logic [`DIM_A-1:0][`INPUT_WIDTH-1:0]in;
//logic [`DIM_C-1:0][`WEIGHT_WIDTH-1:0] weight;
//logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]out; 



logic in [4-1:0];
logic  weight;
logic [`DIM_A-1:0][`ACC_WIDTH-1:0]out; 

multiplication_isoschedule(.clk    (clk),
                            .rst_n (rst_n),
                            .in    (in),
                            .weight(weight),
                            .out   (out)
                        );
    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        genvar i;
        for (i=0; i=i<16; i=i+1) begin
        in[i] = 4'bi;
    endgenerate
    weight = 2;
end




endmodule
