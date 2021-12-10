////////////////////////////////////////////////////////////////////////////
// Author       : Prajyot 
// Coursework   : ECE 751
// Module       : adder_tree
// Description  : Adder tree logic, which takes in the tlut prodict matrix
//                and add relevant indexes to provide the matrix
//                multiplication results. This is the generic for-loop
//                implementation
////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////
////    DO NOT USE THIS FILE            /////////
/////////////////////////////////////////////////

`include "DEF.sv"
module adder_tree(
    input  logic clk,
    input  logic rst_n,
    input  logic [`DIM_ROW2 * `DIM_COL2-1:0][`DIM_ROW1 * `DIM_COL1-1:0][`ACC_WIDTH-1:0]prod,
    output logic [`DIM_ROW1 * `DIM_COL2-1:0][`ACC_WIDTH-1:0]mult
    //TODO: Update the DIM of the output
    //for now, it is = DIM_A
);
    logic [`DIM_ROW1 * `DIM_COL2-1:0][`ACC_WIDTH-1:0] mul_temp;

    genvar i;
    genvar j;
    genvar k;
    generate
    for (i=0; i<`DIM_ROW2 * `DIM_COL2; i=i+1)begin
        for (j=0; j<`DIM_ROW1 * `DIM_COL1; j=j+1) begin
            for (k=0; k<`DIM_ROW1 * `DIM_COL2; k=k+1) begin
                always_ff @(posedge clk or negedge rst_n) begin: matmul
                    if(~rst_n)
                        mul_temp[`DIM_ROW1 * `DIM_COL1*i+j] <=0;
                    else
                    mul_temp[`DIM_ROW1 * `DIM_COL1*i+j] = mul_temp[`DIM_ROW1 * `DIM_COL1*i+j] + prod[`DIM_ROW1 * `DIM_COL1*i+k][`DIM_ROW1 * `DIM_COL1*k+j]; 
                end
            end
        end
    end
    endgenerate

    always_comb begin
        mult <= mul_temp;
    end

endmodule
