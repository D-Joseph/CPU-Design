module reg_32_bit (
  input wire clk, rst, enable,
  input wire [31:0] data_in,
  output reg [31:0] data_out,

);

always @(posedge clk ) begin
  if(rst)
    data_out <= 32'b0;
  else if(enable)
    data_out <= data_in;
end
  
endmodule