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
			//starting out the operations with logical operator, AND OR NOT
			//AND
			input_a <= 5;
			input_b <= 4;
			opcode <= 5'b00101;
			#20
			//OR
			input_a <= 6;
			input_b <= 3;
			opcode <= 5'b00110;
			#20
			//NOT
			input_a <= 5;
			input_b <= 0;
			opcode <= 5'b10010;
			#20
			
			//Negate Operator
			input_a <= 5;
			input_b <= 0;
			opcode <= 5'b10001;
			#20
			
			//Simple Arithmatic Operators
			//Add
			input_a <= 5;
			input_b <= 10;
			opcode <= 5'b00011;
			#20
			//Add negatives
			input_a <= -5;
			input_b <= 8;
			opcode <= 5'b00011;
			#20
			//Two negatives
			input_a <= -55;
			input_b <= -10;
			opcode <= 5'b00011;
			#20
			//Subtract
			input_a <= 75;
			input_b <= 11;
			opcode <= 5'b00100;
			#20
			
			//Multiply and Divide Operators
			//Positive Multiply
			input_a <= 723;
			input_b <= 19;
			opcode <= 5'b01111;
			result_high <= ALU_result[63:32];
			result_low <= ALU_result[31:0];
			#20
			//Negative Multiply
			input_a <= -723;
			input_b <= 19;
			opcode <= 5'b01111;
			result_high <= ALU_result[63:32];
			result_low <= ALU_result[31:0];
			#20
			//Positive Divide
			input_a <= 780;
			input_b <= 40;
			opcode <= 5'b10000;
			result_high <= ALU_result[63:32];
			result_low <= ALU_result[31:0];
			#20
			//Negative Divide
			input_a <= -780;
			input_b <= 40;
			opcode <= 5'b10000;
			result_high <= ALU_result[63:32];
			result_low <= ALU_result[31:0];
			#20
			
			//Rotate and shift operators
			//Shift Right
			input_a <= 5'b00111;
			input_b <= 2;
			opcode <= 5'b00110;
			#20
			//Shift Right Arithmatic
			input_a <= 5'b10111;
			input_b <= 2;
			opcode <= 5'b01000;
			#20
			//Shift left
			input_a <= 10'b0011101110;
			input_b <= 4;
			opcode <= 5'b01001;
			#20
			//Rotate Right
			input_a <= 5'b10111;
			input_b <= 2;
			opcode <= 5'b01010;
			#20
			//Rotate Left
			input_a <= 7'b0001110;
			input_b <= 4;
			opcode <= 5'b01011;
			#20;

		end
	
endmodule
