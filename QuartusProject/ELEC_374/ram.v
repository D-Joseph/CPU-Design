module ram (
  input [31:0] data_in, 
  input [8:0] address, 
  input clk, writeEnable, 
  output [31:0] data_out
);

reg [31:0] RAM[511:0];
reg [31:0] addressRegister;

initial begin : INIT
		$readmemh("controlUnit.mif", RAM); 
end

//synchronous RAM
always@(posedge clk) begin
  if(writeEnable) begin
    RAM[address] <= data_in;
  end
  addressRegister <= address;
end
assign data_out = RAM[addressRegister];
  
endmodule
