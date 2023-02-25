module not_32_bit (
  input wire [31:0] a,
  output wire [31:0] nota
);

assign nota = ~a;
  
endmodule