module negate_32_bit (
  input wire [31:0] a,
  output wire[31:0] y
);

  wire [31:0] tempVal;
  wire cout;

  //To negate a number, you need the two's compliment, which is done by
  //taking the inverse of the number, then adding 1 to it.  
  not_32_bit NOT(.a(a), .y(temp));
  adder_32_bit ADD(.a(temp),.b(32'b1),.cin(1'b0),.cout(cout),.sum(y));

  
endmodule