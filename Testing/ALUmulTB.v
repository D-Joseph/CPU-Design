`timescale 1ns/10ps
module ALU_tb;

	reg clk, clr, IncPC;
	reg [31:0] input_a, input_b;
	reg [4:0] opcode;
	
	wire[63:0] ALU_result;
	reg [31:0] result_low, result_high;
	
	alu ALU_instance(clk,clr,IncPc,input_a, input_b, opcode, ALU_result);			
	
	
	initial
		begin
			input_a <= -750;
			input_b <= 10;
			opcode <= 5'b01111;
			#900
			result_high <= ALU_result[63:32];
			result_low <= ALU_result[31:0];


		end
	
endmodule
