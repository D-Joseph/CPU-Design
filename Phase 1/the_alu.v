module the_alu (
  input clk, clear,

  input wire [31:0] A,
  input wire [31:0] B,
  output wire [31:0] Y, //output
  
  input [4:0] opcode
);

parameter add = 00011, sub = 00100, logicalAnd = 00101, logicalOr = 00110, shr = 00111, shra = 01000, shl = 01001, ror = 01010, 
          rol = 01011, addi = 01100, andi = 01101, ori = 01110, mul = 01111, div = 10000, neg = 10001, logicalNot = 10010, br = 10011,
          jr = 10100, jal = 10101, in = 10110, out = 10111, mfhi = 11000, mflo = 11001, nop = 11010, halt = 11011;

  
always @(*) begin
  case(opcode)
  logicalAnd: begin
    Y = A & B;
  end
  logicalOr : begin
    Y = A | B;
  end
  logicalNot : begin
    Y = ~A;
   end
  shr : begin
    Y = A >> B;
  end
  shra : begin
    Y = A >>> B;
  end
  shl : begin
    Y = A << B;
  end 
  endcase
end


endmodule