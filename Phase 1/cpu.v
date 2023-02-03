
module CPUProject (
  input wire clk, rst,
  output [31:0] bus_contents,
);

//General System Signals

wire HIin,HIout, LOin, LOout, PCin, PCout, IRin,
Zin, Zhighout, Zlowout, Yin, MARin, MDRin, MDRout, read, Mdatain[31.0];


wire [31:0] BusMuxIn-MDR;

wire [31:0] r0_data_out;
wire [31:0] r1_data_out;
wire [31:0] r2_data_out;
wire [31:0] r3_data_out;
wire [31:0] r4_data_out;
wire [31:0] r5_data_out;
wire [31:0] r6_data_out;
wire [31:0] r7_data_out;
wire [31:0] r8_data_out;
wire [31:0] r9_data_out;
wire [31:0] r10_data_out;
wire [31:0] r11_data_out;
wire [31:0] r12_data_out;
wire [31:0] r13_data_out;
wire [31:0] r14_data_out;
wire [31:0] r15_data_out;
wire [31:0] PC_data_out;
wire [31:0] IR_data_out;
wire [31:0] Y_data_out;
wire [31:0] Z_data_out;
wire [31:0] MAR_data_out;
wire [31:0] HI_data_out;
wire [31:0] LO_data_out;


wire [31:0] MDMux_out;

mux_2_to_1 MDMux(read,bus_contents,Mdatain,MDMux_out);
reg_32_bit MDR(clk,rst,MDRin,MDMux_out,BusMuxIn_MDR);

   
endmodule