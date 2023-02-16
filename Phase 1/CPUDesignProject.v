`timescale 1ns/10ps

module CPUDesignProject(
	input PCout, ZLowout, MDRout,R2out, R3out, MARin, ZLowIn, PCin, MDRin, IRin, Yin, IncPC, Read,
   input [4:0] operation,
	input R1in, R2in, R3in,
	input clk,
	input [31:0] MDatain,
	output [31:0] ZLow_data_out
);

	// Wires being used as inputs to the bus's encoder. Originally they are all initialized to 0.
	wire R0out = 0;
	wire R1out = 0;
	//wire R2out = 0;
	//wire R3out = 0;
	wire R4out = 0;
	wire R5out = 0;
	wire R6out = 0;
	wire R7out = 0;
	wire R8out = 0;
	wire R9out = 0;
	wire R10out = 0;
	wire R11out = 0;
	wire R12out = 0;              
	wire R13out = 0;
	wire R14out = 0;
	wire R15out = 0;
	wire HIout = 0;
	wire LOout = 0;
	wire InPortout = 0;
	wire Cout = 0;
	wire ZHighout = 0;

	// Encoder input and output wires
	wire [31:0]	encoder_in;
	wire [4:0] encoder_out;
	

	// Connecting the register output signals to the encoder's input wire
	assign encoder_in = {{8{1'b0}},
								Cout,
								InPortout,
								MDRout,
								PCout,
								ZLowout,
								ZHighout,
								LOout,
								HIout,
								R15out,
								R14out,
								R13out,
								R12out,
								R11out,
								R10out,
								R9out,
								R8out,
								R7out,
								R6out,
								R5out,
								R4out,
								R3out,
								R2out,
								R1out,
								R0out
								};


    // Instatiating 32-to-5 encoder for the bus
    encoder_32_to_5 encoder(encoder_in, encoder_out);
	 
	wire [31:0] bus_contents;

	 //Inputs to the bus's 32-to_1 multiplexer
	wire [31:0] R0_data_out;
	wire [31:0] R1_data_out;
	wire [31:0] R2_data_out;
   wire [31:0] R3_data_out;
	wire [31:0] R4_data_out;
	wire [31:0] R5_data_out;
	wire [31:0] R6_data_out;
	wire [31:0] R7_data_out;
	wire [31:0] R8_data_out;
	wire [31:0] R9_data_out;
	wire [31:0] R10_data_out;
	wire [31:0] R11_data_out;
	wire [31:0] R12_data_out;
	wire [31:0] R13_data_out;
	wire [31:0] R14_data_out;
	wire [31:0] R15_data_out;
	wire [31:0] HI_data_out;
	wire [31:0] LO_data_out;
	wire [31:0] ZHigh_data_out;
	//wire [31:0] ZLow_data_out;
	wire [31:0] PC_data_out;
	wire [31:0] MDR_data_out;
	wire [31:0] InPort_data_out;
	wire [31:0] C_Sign_extend;
	wire [31:0] Y_data_out;

	wire [63:0] C_data_out;
	
	//assign Z_output = ZLow_data_out;
	//assign Z_output = ZLow_data_out;
	//assign BusMuxOut_output = bus_contents;
	

   // Creating all 32-bit registers
	reg_32_bit R0(clk, clr, 1'd0 , bus_contents, R0_data_out); 
	reg_32_bit R1(clk, clr, R1in, bus_contents, R1_data_out);
	reg_32_bit R2(clk, clr, R2in, bus_contents, R2_data_out);
	reg_32_bit R3(clk, clr, R3in, bus_contents, R3_data_out);
	reg_32_bit R4(clk, clr, R4in, bus_contents, R4_data_out);
	reg_32_bit R5(clk, clr, R5in, bus_contents, R5_data_out);
	reg_32_bit R6(clk, clr, R6in, bus_contents, R6_data_out);
	reg_32_bit R7(clk, clr, R7in, bus_contents, R7_data_out);
	reg_32_bit R8(clk, clr, R8in, bus_contents, R8_data_out);
	reg_32_bit R9(clk, clr, R9in, bus_contents, R9_data_out);
	reg_32_bit R10(clk, clr, R10in, bus_contents, R10_data_out);
	reg_32_bit R11(clk, clr, R11in, bus_contents, R11_data_out);
	reg_32_bit R12(clk, clr, R12in, bus_contents, R12_data_out);
	reg_32_bit R13(clk, clr, R13in, bus_contents, R13_data_out);
	reg_32_bit R14(clk, clr, R14in, bus_contents, R14_data_out);
	reg_32_bit R15(clk, clr, R15in, bus_contents, R15_data_out);

	reg_32_bit Y(clk, clr, Yin, bus_contents, Y_data_out);
	reg_32_bit HI_reg(clk, clr, HIin, bus_contents, HI_data_out);
	reg_32_bit LO_reg(clk, clr, LOin, bus_contents, LO_data_out);
	reg_32_bit ZHigh_reg(clk, clr, ZHighIn, C_data_out[63:32], ZHigh_data_out);	
	reg_32_bit ZLow_reg(clk, clr, ZLowIn, C_data_out[31:0], ZLow_data_out);
	reg_32_bit IR(clk, rst, IRin, bus_contents, IR_data_out);

	IncPC_32_bit PC_reg(clk, IncPC, PCin, bus_contents, PC_data_out);
	// Creating the MDR
	// Select signal for the MDR's multiplexer
	
	// Multiplexer used to select an input for the MDR
	wire [31:0] MDR_mux_out;
	mux_2_to_1 MDMux(bus_contents,MDatain, Read,MDR_mux_out);
	reg_32_bit MDR(clk,rst,MDRin,MDR_mux_out,MDR_data_out);

	// Multiplexer to select which data to send out on the bus
	mux_32_to_1 BusMux(
		.BusMuxIn_R0(R0_data_out),
		.BusMuxIn_R1(R1_data_out), 
		.BusMuxIn_R2(R2_data_out),
		.BusMuxIn_R3(R3_data_out),
		.BusMuxIn_R4(R4_data_out),
		.BusMuxIn_R5(R5_data_out),
		.BusMuxIn_R6(R6_data_out),
		.BusMuxIn_R7(R7_data_out),
		.BusMuxIn_R8(R8_data_out),
		.BusMuxIn_R9(R9_data_out),
		.BusMuxIn_R10(R10_data_out),
		.BusMuxIn_R11(R11_data_out),
		.BusMuxIn_R12(R12_data_out),
		.BusMuxIn_R13(R13_data_out),
		.BusMuxIn_R14(R14_data_out),
		.BusMuxIn_R15(R15_data_out),
		.BusMuxIn_HI(HI_data_out),
		.BusMuxIn_LO(LO_data_out),
		.BusMuxIn_Z_HI(ZHigh_data_out),
		.BusMuxIn_Z_LO(ZLow_data_out),
		.BusMuxIn_PC(PC_data_out),
		.BusMuxIn_MDR(MDR_data_out),
		.BusMuxIn_In_Port(Inport_data_out),
		.C_Sign_Extended(C_Sign_extend), //TODO: take care of this one!
		.BusMuxOut(bus_contents),
		.select(encoder_out)
		);



	//instantiate alu
	alu the_alu(
	.clk(clk),
	.clr(clr), 
	.A(Y_data_out),
	.B(bus_contents),
	.opcode(operation),
	.C(C_data_out)
	);
	
//assign MDR_output = MDR_data_out;

endmodule

`timescale 1ns/10ps

module CPUDesignProject(
	input PCout,ZHighout, ZLowout, MDRout,R6out, R7out, MARin, ZLowIn,ZHighIn,PCin, MDRin, IRin, Yin, IncPC, Read, HIin, LOin,
   input [4:0] operation,
	input R6in, R7in,
	input clk, clr,
	input [31:0] MDatain,
	output [31:0] ZHigh_data_out
);

	// Wires being used as inputs to the bus's encoder. Originally they are all initialized to 0.
	wire R0out = 0;
	wire R1out = 0;
	wire R2out = 0;
	wire R3out = 0;
	wire R4out = 0;
	wire R5out = 0;
	//wire R6out = 0;
	//wire R7out = 0;
	wire R8out = 0;
	wire R9out = 0;
	wire R10out = 0;
	wire R11out = 0;
	wire R12out = 0;              
	wire R13out = 0;
	wire R14out = 0;
	wire R15out = 0;
	wire HIout = 0;
	wire LOout = 0;
	wire InPortout = 0;
	wire Cout = 0;
	//wire ZHighout = 0;
	//wire ZLowout = 0;

	// Encoder input and output wires
	wire [31:0]	encoder_in;
	wire [4:0] encoder_out;
	

	// Connecting the register output signals to the encoder's input wire
	assign encoder_in = {{8{1'b0}},
								Cout,
								InPortout,
								MDRout,
								PCout,
								ZLowout,
								ZHighout,
								LOout,
								HIout,
								R15out,
								R14out,
								R13out,
								R12out,
								R11out,
								R10out,
								R9out,
								R8out,
								R7out,
								R6out,
								R5out,
								R4out,
								R3out,
								R2out,
								R1out,
								R0out
								};


    // Instatiating 32-to-5 encoder for the bus
    encoder_32_to_5 encoder(encoder_in, encoder_out);
	 
	wire [31:0] bus_contents;

	 //Inputs to the bus's 32-to_1 multiplexer
	wire [31:0] R0_data_out;
	wire [31:0] R1_data_out;
	wire [31:0] R2_data_out;
   wire [31:0] R3_data_out;
	wire [31:0] R4_data_out;
	wire [31:0] R5_data_out;
	wire [31:0] R6_data_out;
	wire [31:0] R7_data_out;
	wire [31:0] R8_data_out;
	wire [31:0] R9_data_out;
	wire [31:0] R10_data_out;
	wire [31:0] R11_data_out;
	wire [31:0] R12_data_out;
	wire [31:0] R13_data_out;
	wire [31:0] R14_data_out;
	wire [31:0] R15_data_out;
	wire [31:0] HI_data_out;
	wire [31:0] LO_data_out;
	//wire [31:0] ZHigh_data_out;
	wire [31:0] ZLow_data_out;
	wire [31:0] PC_data_out;
	wire [31:0] MDR_data_out;
	wire [31:0] InPort_data_out;
	wire [31:0] C_Sign_extend;
	wire [31:0] Y_data_out;

	wire [63:0] C_data_out;
	
	//assign Z_output = ZLow_data_out;
	//assign Z_output = ZLow_data_out;
	//assign BusMuxOut_output = bus_contents;
	

   // Creating all 32-bit registers
	reg_32_bit R0(clk, clr, 1'd0 , bus_contents, R0_data_out); 
	reg_32_bit R1(clk, clr, R1in, bus_contents, R1_data_out);
	reg_32_bit R2(clk, clr, R2in, bus_contents, R2_data_out);
	reg_32_bit R3(clk, clr, R3in, bus_contents, R3_data_out);
	reg_32_bit R4(clk, clr, R4in, bus_contents, R4_data_out);
	reg_32_bit R5(clk, clr, R5in, bus_contents, R5_data_out);
	reg_32_bit R6(clk, clr, R6in, bus_contents, R6_data_out);
	reg_32_bit R7(clk, clr, R7in, bus_contents, R7_data_out);
	reg_32_bit R8(clk, clr, R8in, bus_contents, R8_data_out);
	reg_32_bit R9(clk, clr, R9in, bus_contents, R9_data_out);
	reg_32_bit R10(clk, clr, R10in, bus_contents, R10_data_out);
	reg_32_bit R11(clk, clr, R11in, bus_contents, R11_data_out);
	reg_32_bit R12(clk, clr, R12in, bus_contents, R12_data_out);
	reg_32_bit R13(clk, clr, R13in, bus_contents, R13_data_out);
	reg_32_bit R14(clk, clr, R14in, bus_contents, R14_data_out);
	reg_32_bit R15(clk, clr, R15in, bus_contents, R15_data_out);

	reg_32_bit Y(clk, clr, Yin, bus_contents, Y_data_out);
	reg_32_bit HI_reg(clk, clr, HIin, bus_contents, HI_data_out);
	reg_32_bit LO_reg(clk, clr, LOin, bus_contents, LO_data_out);
	reg_32_bit ZHigh_reg(clk, clr, ZHighIn, C_data_out[63:32], ZHigh_data_out);	
	reg_32_bit ZLow_reg(clk, clr, ZLowIn, C_data_out[31:0], ZLow_data_out);
	reg_32_bit IR(clk, clr, IRin, bus_contents, IR_data_out);

	IncPC_32_bit PC_reg(clk, IncPC, PCin, bus_contents, PC_data_out);
	// Creating the MDR
	// Select signal for the MDR's multiplexer
	
	// Multiplexer used to select an input for the MDR
	wire [31:0] MDR_mux_out;
	mux_2_to_1 MDMux(bus_contents,MDatain, Read,MDR_mux_out);
	reg_32_bit MDR(clk,rst,MDRin,MDR_mux_out,MDR_data_out);

	// Multiplexer to select which data to send out on the bus
	mux_32_to_1 BusMux(
		.BusMuxIn_R0(R0_data_out),
		.BusMuxIn_R1(R1_data_out), 
		.BusMuxIn_R2(R2_data_out),
		.BusMuxIn_R3(R3_data_out),
		.BusMuxIn_R4(R4_data_out),
		.BusMuxIn_R5(R5_data_out),
		.BusMuxIn_R6(R6_data_out),
		.BusMuxIn_R7(R7_data_out),
		.BusMuxIn_R8(R8_data_out),
		.BusMuxIn_R9(R9_data_out),
		.BusMuxIn_R10(R10_data_out),
		.BusMuxIn_R11(R11_data_out),
		.BusMuxIn_R12(R12_data_out),
		.BusMuxIn_R13(R13_data_out),
		.BusMuxIn_R14(R14_data_out),
		.BusMuxIn_R15(R15_data_out),
		.BusMuxIn_HI(HI_data_out),
		.BusMuxIn_LO(LO_data_out),
		.BusMuxIn_Z_HI(ZHigh_data_out),
		.BusMuxIn_Z_LO(ZLow_data_out),
		.BusMuxIn_PC(PC_data_out),
		.BusMuxIn_MDR(MDR_data_out),
		.BusMuxIn_In_Port(Inport_data_out),
		.C_Sign_Extended(C_Sign_extend), //TODO: take care of this one!
		.BusMuxOut(bus_contents),
		.select(encoder_out)
		);



	//instantiate alu
	alu the_alu(
	.clk(clk),
	.clr(clr), 
	.A(Y_data_out),
	.B(bus_contents),
	.opcode(operation),
	.C(C_data_out)
	);
	
//assign MDR_output = MDR_data_out;

endmodule