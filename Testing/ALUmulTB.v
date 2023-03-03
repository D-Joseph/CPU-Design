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

`timescale 1ns/10ps
module ALU_tb;

	reg clk, clr, IncPC;
	reg [31:0] input_a, input_b;
	reg [4:0] opcode;
	
	wire signed [63:0] ALU_result;
	//reg signed [31:0] result_low, result_high;
	
	alu ALU_instance(clk,clr,IncPc,input_a, input_b, opcode, ALU_result);			
	
	
	initial
		begin
			//result_high <= 0;
			//result_low <= 0;
			//starting out the operations with logical operator, AND OR NOT
			//AND
			input_a <= 5;
			input_b <= 4;
			opcode <= 5'b00101;
			#100
			//OR
			input_a <= 6;
			input_b <= 3;
			opcode <= 5'b00110;
			#100
			//NOT
			input_a <= 5;
			input_b <= 0;
			opcode <= 5'b10010;
			#100
			//Negate Operator
			input_a <= 5;
			input_b <= 0;
			opcode <= 5'b10001;
			#100
			
			//Simple Arithmatic Operators
			//Add
			input_a <= 5;
			input_b <= 10;
			opcode <= 5'b00011;
			#100
			//Add negatives
			input_a <= -5;
			input_b <= 8;
			opcode <= 5'b00011;
			#100
			//Two negatives
			input_a <= -55;
			input_b <= -10;
			opcode <= 5'b00011;
			#100
			//Subtract
			input_a <= 75;
			input_b <= 11;
			opcode <= 5'b00100;
			#100
			
			//Multiply and Divide Operators
			//Positive Multiply
			//result_high <= 0;
			//result_low <= 0;
			input_a <= 723;
			input_b <= 19;
			opcode <= 5'b01111;
			//#50
			//result_high <= ALU_result[63:32];
			//result_low <= ALU_result[31:0];
			#100
			
			//Negative Multiply
			//result_high <= 0;
			//result_low <= 0;
			input_a <= -723;
			input_b <= 19;
			opcode <= 5'b01111;
			//#50
			//result_high <= ALU_result[63:32];
			//result_low <= ALU_result[31:0];
			#100
			
			//Positive Divide
			//result_high <= 0;
			//result_low <= 0;
			input_a <= 780;
			input_b <= 40;
			opcode <= 5'b10000;
			//#50
			//result_high <= ALU_result[63:32];
			//result_low <= ALU_result[31:0];
			#100
			
			//Negative Divide
			//result_high <= 0;
			//result_low <= 0;
			input_a <= -780;
			input_b <= 40;
			opcode <= 5'b10000;
			//#50
			//result_high <= ALU_result[63:32];
			//result_low <= ALU_result[31:0];
			#100
			
			//Rotate and shift operators
			//Shift Right
			input_a <= 5'b00111;
			input_b <= 2;
			opcode <= 5'b00111;
			#100
			//Shift Right Arithmatic
			input_a <= -10;
			input_b <= 2;
			opcode <= 5'b01000;
			#100
			//Shift left
			input_a <= 10'b0011101110;
			input_b <= 4;
			opcode <= 5'b01001;
			#100
			//Rotate Right
			input_a <= 5'b10111;
			input_b <= 2;
			opcode <= 5'b01010;
			#100
			//Rotate Left
			input_a <= 7'b0001110;
			input_b <= 4;
			opcode <= 5'b01011;
			#100;

		end
	
endmodule
