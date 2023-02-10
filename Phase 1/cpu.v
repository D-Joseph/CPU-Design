`timescale 1ns/10ps

module CPUProject (
  input wire clk, rst,
  input wire clr,
  input wire Mdatain,
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


reg_32_bit R0(clk, clr, 1'd0 , bus_contents, R0_data_out); 
reg_32_bit R1(clk, clr, R1_enable, bus_contents, R1_data_out);
reg_32_bit R2(clk, clr, R2_enable, bus_contents, R2_data_out);
reg_32_bit R3(clk, clr, R3_enable, bus_contents, R3_data_out);
reg_32_bit R4(clk, clr, R4_enable, bus_contents, R4_data_out);
reg_32_bit R5(clk, clr, R5_enable, bus_contents, R5_data_out);
reg_32_bit R6(clk, clr, R6_enable, bus_contents, R6_data_out);
reg_32_bit R7(clk, clr, R7_enable, bus_contents, R7_data_out);
reg_32_bit R8(clk, clr, R8_enable, bus_contents, R8_data_out);
reg_32_bit R9(clk, clr, R9_enable, bus_contents, R9_data_out);
reg_32_bit R10(clk, clr, R10_enable, bus_contents, R10_data_out);
reg_32_bit R11(clk, clr, R11_enable, bus_contents, R11_data_out);
reg_32_bit R12(clk, clr, R12_enable, bus_contents, R12_data_out);
reg_32_bit R13(clk, clr, R13_enable, bus_contents, R13_data_out);
reg_32_bit R14(clk, clr, R14_enable, bus_contents, R14_data_out);
reg_32_bit R15(clk, clr, R15_enable, bus_contents, R15_data_out);
reg_32_bit HI_reg(clk, clr, HI_enable, bus_contents, HI_data_out);
reg_32_bit LO_reg(clk, clr, LO_enable, bus_contents, LO_data_out);
reg_32_bit ZHigh_reg(clk, clr, ZHigh_enable, bus_contents, ZHigh_data_out);	
reg_32_bit ZLow_reg(clk, clr, ZLow_enable, bus_contents, ZLow_data_out);
reg_32_bit PC_reg(clk, clr, PC_enable, bus_contents, PC_data_out);
reg_32_bit InPort_reg(clk, clr, InPort_enable, bus_contents, InPort_data_out);
reg_32_bit C_reg(clk, clr, C_enable, bus_contents, C_data_out);

mux_2_to_1 MDMux(read,bus_contents,Mdatain,MDMux_out);
reg_32_bit MDR(clk,rst,MDRin,MDMux_out,BusMuxIn_MDR);

   
endmodule