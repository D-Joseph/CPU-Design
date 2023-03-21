`timescale 1ns / 1ps

module IncPC_32_bit #(parameter qInitial = 0)(
	input clk, IncPC, enable,
	input [31:0] curPC,
	output reg[31:0] newPC
	);
	
initial newPC = qInitial;
	
always @ (posedge clk)
	begin
		if(IncPC == 1 && enable ==1)
			newPC <= curPC + 1;
		else if (enable == 1)
			newPC <= curPC;
	end
				
endmodule
