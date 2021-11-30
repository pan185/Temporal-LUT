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
    output logic [`DIM_A-1:0][`ACC_WIDTH-1:0]mult
    //TODO: Update the DIM of the output
    //for now, it is = DIM_A
);
    logic [`DIM_A-1:0][`ACC_WIDTH-1:0] mul_temp;

    always_ff @(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            mul_temp <= 0;
        else
        begin

        end
    end




