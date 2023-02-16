module alu (
  input clk, clr, IncPC,

  input wire [31:0] A,
  input wire [31:0] B,

  input [4:0] opcode,
  
  output reg [63:0] C

);

parameter add = 5'b00011, sub = 5'b00100, logicalAnd = 5'b00101, logicalOr = 5'b00110, shr = 5'b00111, shra = 5'b01000, shl = 5'b01001, ror = 5'b01010, 
          rol = 5'b01011, addi = 5'b01100, andi = 5'b01101, ori = 5'b01110, mul = 5'b01111, div = 5'b10000, neg = 5'b10001, logicalNot = 5'b10010, br = 5'b10011,
          jr = 5'b10100, jal = 5'b10101, in = 5'b10110, out = 5'b10111, mfhi = 5'b11000, mflo = 5'b11001, nop = 5'b11010, halt = 5'b11011;

wire [31:0] IncPC_out, neg_out, not_out, adder_sum, adder_cout, sub_sum, sub_cout, rol_out, ror_out;
wire [63:0] mul_out , div_out;
  
always @(*) begin
  case(opcode)
  logicalAnd: begin
    C[31:0] <= A & B;
    C[63:32] <= 32'b0;
  end
  logicalOr : begin
    C[31:0] <= A | B;
    C[63:32] <= 32'b0;
  end
  add : begin
    C[31:0] <= adder_sum;
    C[63:32] <= 32'b0;
  end
  addi : begin
    C[31:0] <= adder_sum;
    C[63:32] <= 32'b0;
  end
  sub : begin
    C[31:0] <= sub_sum;
    C[63:32] <= 32'b0;
  end
  mul : begin
    C[63:32] <= mul_out[63:32];
    C[31:0] <= mul_out[31:0];
  end
  div : begin
    C[63:0] <= div_out;
  end
  shr : begin
    C[31:0] <= A >> B;
    C[63:32] <= 32'b0;
  end
  shra : begin
    C[31:0] <= A >>> B;
    C[63:32] <= 32'b0;
  end
  shl : begin
    C[31:0] <= A << B;
    C[63:32] <= 32'b0;
  end 
  ror : begin
    C[31:0] <= ror_out;
    C[63:32] <= 32'b0;
  end
  rol : begin
    C[31:0] <= rol_out;
    C[63:32] <= 32'b0;
  end
  neg : begin
    C[63:32] <= 32'b0;
    C[31:0] <= neg_out;
  end
  logicalNot : begin
    C[31:0] <= ~A;
    C[63:32] <= 32'b0;
  end
  endcase
end


adder_32_bit adder(.a(A),.b(B),.cin(1'b0),.cout(adder_cout),.sum(adder_sum));
sub_32_bit subtraction(.a(A),.b(B),.cin(1'b0),.cout(sub_cout),.sum(sub_sum));
multiplication_32_bit mutlipication(.a(A), .b(B), .result(mul_out));
negate_32_bit negation(.a(A), .neg_a(neg_out));
rol_32_bit rotateR(a,b,rol_out);
rotate_right_32_bit rotateL(a,b,ror_out);
IncPC_32_bit incPC(IncPC, RPC, PC_out);



endmodule