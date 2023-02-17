module multiplication_32_bit (
  input wire[31:0] a,
  input wire[31:0] b,
  output wire[63:0] z
);

integer i,j;
reg [2:0] groupedBits[15:0];
reg [31:0] partialProduct;
reg signed [63:0] runningSum;

wire [31:0] neg_a;
assign neg_a = -a; // 2s Complement of a

always @(a or b or neg_a) begin
  groupedBits[0] = {b[1], b[0], 1'b0};
  for(i=1; i <= 15; i = i + 1) begin
    groupedBits[i] = {b[2*i+1], b[2*i], b[2*i-1]};
  end
  for(j = 0; j <= 15; j = j + 1) begin
	  case(groupedBits[j])
		 3'b001 : partialProduct = a;
		 3'b010 : partialProduct = a;
		 3'b101 : partialProduct = neg_a;
		 3'b110 : partialProduct = neg_a;
		 3'b011 : partialProduct = {a << 1};
		 3'b100 : partialProduct = {neg_a << 1};
		 default : partialProduct = 31'b0;
	  endcase
     runningSum = runningSum + (partialProduct << 2 * j);
	  end
end
assign z = runningSum;

endmodule