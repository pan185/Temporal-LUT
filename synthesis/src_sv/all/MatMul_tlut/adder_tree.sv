////////////////////////////////////////////////////////////////////////////
// Author       : Prajyot 
// Coursework   : ECE 751
// Module       : adder_tree
// Description  : Adder tree logic, which takes in the tlut prodict matrix
//                and add relevant indexes to provide the matrix
//                multiplication results. Generated using gen.cpp file
////////////////////////////////////////////////////////////////////////////

`include "DEF.sv"
module adder_tree(
    input  logic clk,
    input  logic rst_n,
    input  logic [`DIM_ROW2 * `DIM_COL2 -1:0][`DIM_ROW1 * `DIM_COL1 -1:0][`ACC_WIDTH-1:0]prod,
    output logic [`DIM_ROW1 * `DIM_COL2 -1:0][`ACC_WIDTH-1:0]mult
    //TODO: Update the DIM of the output
    //for now, it is = DIM_A
    //Aish: Changed DIM_A = DIM_ROW1 * DIM_COL1
    //Aish: Changed DIM_C = DIM_ROW2 * DIM_COL2
    //Aish: Changed DIM_MULT = DIM_ROW1 * DIM_COL2
);
    logic [`DIM_ROW1 * `DIM_COL2 -1:0][`ACC_WIDTH-1:0] mul_temp;

    always_ff @(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            mul_temp <= 0;
        else
        begin
        // Below code generated using ./_gen_add_logic <array dim> 
mul_temp[0] = prod[0][0] + prod[1][2];
mul_temp[1] = prod[0][1] + prod[1][3];
mul_temp[2] = prod[2][0] + prod[3][2];
mul_temp[3] = prod[2][1] + prod[3][3];
        end
    end
    
    always_comb begin
        mult <= mul_temp;
    end

endmodule
