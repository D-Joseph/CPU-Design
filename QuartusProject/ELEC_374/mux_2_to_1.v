module mux_2_to_1 (
  input wire[31:0] mux_in_1, 
  input wire [31:0] mux_in_2,
  input wire select,
  output reg [31:0] mux_out
);

always @(*) begin
  if(select)
    mux_out <= mux_in_2;
  else
    mux_out <= mux_in_1;
end
  
endmodule

