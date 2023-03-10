`timescale 1ns / 1ps

module IncPC_32_bit #(parameter qInitial = 0)(
	input clk, IncPC,
	input [31:0] inputPC,
	output reg[31:0] newPC
	);
	
initial newPC = qInitial;
	
always @ (posedge clk)
	begin
		if(IncPC == 1)
			newPC <= inputPC + 1;
		else
			newPC <= inputPC;
	end
				
endmodule