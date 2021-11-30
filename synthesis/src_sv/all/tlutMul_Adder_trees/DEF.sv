//`define CONFIG1
`define CONFIG_MATMUL_1D
//`define WORKLOAD1
// `define CONFIG2
//`define WORKLOAD_SMALL_A
`define WORKLOAD_MATMUL_1D
//`define WORKLOAD_MEDIAN_A
//`define WORKLOAD_LARGE_A


`ifdef CONFIG1
    `define INPUT_WIDTH 4
    `define WEIGHT_WIDTH 8
    `define ACC_WIDTH 12
`endif

`ifdef CONFIG_MATMUL_1D
    `define INPUT_WIDTH 4
    `define WEIGHT_WIDTH 4
    `define ACC_WIDTH 8
`endif

`ifdef CONFIG2
    `define INPUT_WIDTH 8
    `define WEIGHT_WIDTH 8
    `define ACC_WIDTH 16
`endif

`ifdef WORKLOAD1
    `define DIM_A 9
    `define DIM_B 5 //Mapped temporally (scheduling)
    `define DIM_C 5
`endif

`ifdef WORKLOAD_SMALL_A
    `define DIM_A 8
    `define DIM_B 1 //Mapped temporally (scheduling)
    `define DIM_C 1
`endif

`ifdef WORKLOAD_MEDIAN_A
    `define DIM_A 16
    `define DIM_B 1 //Mapped temporally (scheduling)
    `define DIM_C 1
`endif

`ifdef WORKLOAD_LARGE_A
    `define DIM_A 32
    `define DIM_B 1 //Mapped temporally (scheduling)
    `define DIM_C 1
`endif

//`ifdef WORKLOAD_MATMUL_1D
//    `define DIM_A 9
//    //`define DIM_B 1 //Mapped temporally (scheduling)
//    `define DIM_C 9
//    `define DIM_MULT 9
//`endif

`ifdef WORKLOAD_MATMUL_1D
    `define DIM_ROW1 9
    `define DIM_COL1 9
    `define DIM_ROW2 9
    `define DIM_COL2 9
    `define DIM_A $DIM_ROW1 * $DIM_COL1
    //`define DIM_B 1 //Mapped temporally (scheduling)
    `define DIM_C $DIM_ROW2 * $DIM_COL2
    `define DIM_MULT $DIM_ROW1 * $DIM_COL2
`endif
