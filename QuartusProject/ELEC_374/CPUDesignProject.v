`timescale 1ns/10ps

module CPUDesignProject(
	input PCout, 
	input ZLowout, 
	input ZHighout,
	input MDRout, MDRin, MARin,
	input ZLowIn,ZHighIn, HIin, HIout, LOin, LOout, Cout, ramWE,PCin, IRin, IncPC, Yin, Read,
	input Gra, Grb, Grc, R_in, R_out, BAout, CONin,InPortout,
	input [15:0] R_enableIn, Rout_in,
	input OutPortIn, InPortIn,
   output [4:0] operation,
	input clk,clr,
	input [31:0] MDatain, 
	input wire [31:0] inport_data_in,
	output wire [31:0] outport_data_out,
	output [31:0] bus_contents
);

	wire [15:0] enableR_IR; 
	wire [15:0] Rout_IR;
	reg  [15:0]  regIn; 
	reg  [15:0]  Rout;
	wire [3:0]  decoder_in;
	 
	always@(*)begin		
		if (enableR_IR)regIn<=enableR_IR; 
		else regIn<=R_enableIn;
		if (Rout_IR)Rout<=Rout_IR; 
		else Rout<=Rout_in;
	end 
	/*
	Signal and wire declarations to be used in the Datapath
	*/ 
	//wire [31:0] bus_contents;

    //These are the inputs to the bus multiplexer
	wire [31:0] R0_data_out, R1_data_out,R2_data_out,R3_data_out, R4_data_out, R5_data_out, R6_data_out, R7_data_out, R8_data_out, R9_data_out;
	wire [31:0] R10_data_out, R11_data_out, R12_data_out, R13_data_out, R14_data_out, R15_data_out, HI_data_out, LO_data_out;
	wire [31:0] ZHigh_data_out, ZLow_data_out, IR_data_out;
	wire [31:0] PC_data_out, MDR_data_out, RAM_data_out, MAR_data_out_32, C_Sign_extend, Y_data_out ,pcData;
	wire [63:0] C_data_out;
	wire [8:0] MAR_data_out;

	// Encoder input and output wires]
	wire [31:0]	encoder_in;
	wire [4:0] encoder_out;
	
	// Connecting the register output signals to the encoder's input wire
	assign encoder_in = {{8{1'b0}},Cout,InPortout,MDRout,PCout,ZLowout,ZHighout,LOout,HIout,Rout};

    // Instatiating 32-to-5 encoder
    encoder_32_to_5 encoder(encoder_in, encoder_out);

    //Creating all 32-bit registers
	wire [31:0] r0_AND_input;
	assign R0_data_out = {32{!BAout}} & r0_AND_input; //revision to R0
	reg_32_bit R0(clk, clr, regIn[0] , bus_contents, r0_AND_input); 
	reg_32_bit #(32'h22) R1(clk, clr, regIn[1], bus_contents, R1_data_out);
	reg_32_bit #(55) R2(clk, clr, regIn[2], bus_contents, R2_data_out);
	reg_32_bit #(32'b110000) R3(clk, clr, regIn[3], bus_contents, R3_data_out);
	reg_32_bit #(32'h67) R4(clk, clr, regIn[4], bus_contents, R4_data_out);
	reg_32_bit R5(clk, clr, regIn[5], bus_contents, R5_data_out);
	reg_32_bit #(0) R6(clk, clr, regIn[6], bus_contents, R6_data_out);
	reg_32_bit R7(clk, clr, regIn[7], bus_contents, R7_data_out);
	reg_32_bit R8(clk, clr, regIn[8], bus_contents, R8_data_out);
	reg_32_bit R9(clk, clr, regIn[9], bus_contents, R9_data_out);
	reg_32_bit R10(clk, clr, regIn[10], bus_contents, R10_data_out);
	reg_32_bit R11(clk, clr, regIn[11], bus_contents, R11_data_out);
	reg_32_bit R12(clk, clr, regIn[12], bus_contents, R12_data_out);
	reg_32_bit R13(clk, clr, regIn[13], bus_contents, R13_data_out);
	reg_32_bit R14(clk, clr, regIn[14], bus_contents, R14_data_out);
	reg_32_bit R15(clk, clr, regIn[15], bus_contents, R15_data_out);
	reg_32_bit Y(clk, clr, Yin, bus_contents, Y_data_out);
	reg_32_bit #(53292) HI_reg(clk, clr, HIin, bus_contents, HI_data_out);
	reg_32_bit #(55555555) LO_reg(clk, clr, LOin, bus_contents, LO_data_out);
	reg_32_bit ZHigh_reg(clk, clr, ZHighIn, C_data_out[63:32], ZHigh_data_out);	
	reg_32_bit ZLow_reg(clk, clr, ZLowIn, C_data_out[31:0], ZLow_data_out);

	reg_32_bit IR(clk, rst, IRin, bus_contents, IR_data_out);

	//reg_32_bit PC_reg(clk, clr,PCin, bus_contents, PC_data_out);
   IncPC_32_bit #(17) PC_reg(clk, IncPC, PCin, bus_contents, PC_data_out);
	
	reg_32_bit OutPort(clk, clr, OutPortIn, bus_contents, outport_data_out);
	reg_32_bit #(-42010) InPort(clk, clr, InPortIn, Inport_data_out, BusMuxIn_In_Port);

	//Select and encode Logic and CON FF
	selectencodelogic selEn(IR_data_out, Gra, Grb, Grc, R_in, R_out, BAout, C_Sign_extend, enableR_IR, Rout_IR, operation,decoder_in);
	CONFF_logic conff(IR_data_out[20:19],bus_contents, CONin, CONout);
	
	//MDR
	wire [31:0] MDR_mux_out;
	//First create the 2-1 mux that selects either the RAM or the bus contents
	mux_2_to_1 MDMux(bus_contents,RAM_data_out, Read,MDR_mux_out);
	//Create the actual MDR itself by instantiating a regular 32 bit reg
	reg_32_bit MDR(clk,rst,MDRin,MDR_mux_out,MDR_data_out);

	//This is done to avoid having to make an MDR unit module
	reg_32_bit MAR(clk,rst,MARin, bus_contents, MAR_data_out_32);
	assign MAR_data_out = MAR_data_out_32[8:0];

	//memRAM ramModule(MAR_data_out,clk,MDR_data_out,ramWE,RAM_data_out);
	
	ram ramModule(MDR_data_out,MAR_data_out,clk,ramWE,RAM_data_out);

	// Multiplexer to select which data to send out on the bus
	mux_32_to_1 BusMux(
		.BusMuxIn_R0(R0_data_out),.BusMuxIn_R1(R1_data_out), .BusMuxIn_R2(R2_data_out),.BusMuxIn_R3(R3_data_out),
		.BusMuxIn_R4(R4_data_out),.BusMuxIn_R5(R5_data_out), .BusMuxIn_R6(R6_data_out),.BusMuxIn_R7(R7_data_out),
		.BusMuxIn_R8(R8_data_out),.BusMuxIn_R9(R9_data_out),.BusMuxIn_R10(R10_data_out),.BusMuxIn_R11(R11_data_out),
		.BusMuxIn_R12(R12_data_out),.BusMuxIn_R13(R13_data_out),.BusMuxIn_R14(R14_data_out),.BusMuxIn_R15(R15_data_out),
		.BusMuxIn_HI(HI_data_out),.BusMuxIn_LO(LO_data_out),.BusMuxIn_Z_HI(ZHigh_data_out),.BusMuxIn_Z_LO(ZLow_data_out),
		.BusMuxIn_PC(PC_data_out),.BusMuxIn_MDR(MDR_data_out),.BusMuxIn_In_Port(Inport_data_out),.C_Sign_Extended(C_Sign_extend),
		.BusMuxOut(bus_contents),.select(encoder_out)
		);

	//instantiate the alu
	alu the_alu(
	.clk(clk),
	.clr(clr), 
	.branch_flag(CONout),
	.A(Y_data_out),
	.B(bus_contents),
	//.RPC(PC_data_out),
	.opcode(operation),
	.C(C_data_out)
	//.IncPC(IncPC),
	//.aluPCout(pcData)
	);

endmodule
