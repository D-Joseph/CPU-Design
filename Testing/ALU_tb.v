`timescale 1ns/10ps
module ALU_tb;

	reg [31:0] input_a, input_b, input_c;
	reg [4:0] opcode;
	
	wire[63:0] ALU_result;
	
	alu ALU_instance(input_a, input_b,input_c, opcode, ALU_result);			
	
	
	initial
		begin
			input_a <= 19;
			input_b <= 13;
			opcode <= 5'b00100;
			
		#200 
			opcode <= 5'b01111;
		end
	
endmodule
