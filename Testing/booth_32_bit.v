module booth_32_bit (
  input wire [31:0] a,
  input wire [31:0] b,
  output wire [63:0] c
);

reg [2:0] groupedBits[15:0];
reg [31:0] partialProduct;
reg signed [63:0] runningSum;

assign neg_a = {~a[31], ~a} + 1; // 2s Complement of a

always @(a or b) begin
  groupedBits[0] = {b[1], b[0], 1'b0};
  for(i=1; i <=15; i = i + 1)begin
    groupedBits[i] = {b[2*i+1], b[2*i], b[2*i-1]}
  end
for(i = 0; i <= 15; i = i + 1) begin
  case(groupedBits[i])
    b'001, b'010 : partialProduct = a;
    b'101, b'110 : partialProduct = neg_a;
    b'011 : partialProduct = {a << 1};
    b'100 : partialProduct = {neg_a << 1};
    default: partialProduct = 31'b0;
  endcase
  runningSum = runningSum + (partialProduct 2 * i);
  end
end
assign c = runningSum;

endmodule