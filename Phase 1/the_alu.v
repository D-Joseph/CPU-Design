module the_alu (
  input clk, clear,

  input wire [31:0] A,
  input wire [31:0] B,
  input wire [31:0] Y, //output
  
  output wire [63:0] C;

  input [4:0] opcode

);

parameter add = 00011, sub = 00100, logicalAnd = 00101, logicalOr = 00110, shr = 00111, shra = 01000, shl = 01001, ror = 01010, 
          rol = 01011, addi = 01100, andi = 01101, ori = 01110, mul = 01111, div = 10000, neg = 10001, logicalNot = 10010, br = 10011,
          jr = 10100, jal = 10101, in = 10110, out = 10111, mfhi = 11000, mflo = 11001, nop = 11010, halt = 11011;

wire [31:0] neg_out, not_out, adder_sum, adder_cout, sub_sum, sub_cout, rol_out, ror_out;
wire [63:0] mul_out , div_out;
  
always @(*) begin
  case(opcode)
  logicalAnd: begin
    Y = A & B;
  end
  logicalOr : begin
    Y = A | B;
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
    C[63:32] <= ~mul_out;
    C[31:0] <= mul_out;
  end
  div : begin
    C[63:0] <= div_out;
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
    Y = ~A;
  end
  endcase
end


adder_32_bit adder(.a(A),.b(B),.cin(1'b0),.cout(adder_cout),.sum(adder_sum));
sub_32_bit subtraction(.a(A),.b(B),.cin(1'b0),.cout(sub_cout),.sum(sub_sum));
multiplication_32_bit mutlipication(.a(A), .b(B), .product(mul_out));
negate_32_bit negation(.a(A), .y(neg_out));
rotate_left_32_bit rotateR(y,a,rol_out);
rotate_right_32_bit rotateL(y,b,ror_out);


endmodule