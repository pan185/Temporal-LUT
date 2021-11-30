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
    input  logic [`DIM_C-1:0][`DIM_A-1:0][`ACC_WIDTH-1:0]prod,
    output logic [`DIM_MULT-1:0][`ACC_WIDTH-1:0]mult
    //TODO: Update the DIM of the output
    //for now, it is = DIM_A
);
    logic [`DIM_MULT-1:0][`ACC_WIDTH-1:0] mul_temp;

    always_ff @(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            mul_temp <= 0;
        else
        begin
        // Below code generated using ./_gen_add_logic <array dim> 
            mul_temp[0]<= prod[0][0] + prod[1][3] + prod[2][6];     
            mul_temp[1]<= prod[0][1] + prod[1][4] + prod[2][7];
            mul_temp[2]<= prod[0][2] + prod[1][5] + prod[2][8];
            mul_temp[3]<= prod[3][0] + prod[4][3] + prod[5][6];
            mul_temp[4]<= prod[3][1] + prod[4][4] + prod[5][7];
            mul_temp[5]<= prod[3][2] + prod[4][5] + prod[5][8];
            mul_temp[6]<= prod[6][0] + prod[7][3] + prod[8][6];
            mul_temp[7]<= prod[6][1] + prod[7][4] + prod[8][7];
            mul_temp[8]<= prod[6][2] + prod[7][5] + prod[8][8];
        end
    end
    
    always_comb begin
        mult <= mul_temp;
    end

endmodule
