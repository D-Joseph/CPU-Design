`timescale 1ns/10ps
module IncPC_32_bit #(parameter qInitial = 0)(
    input IncPC,
    input [31:0] inputPC,
    output reg[31:0] newPC
    );

initial newPC = qInitial;
always@(IncPC)begin
   if (IncPC)
     newPC = inputPC + 1;
end
endmodule