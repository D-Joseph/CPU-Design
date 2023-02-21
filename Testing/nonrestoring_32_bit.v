module nonrestoring_32_bit (
  input wire [31:0] a,
  input wire [31:0] b,
  output wire [63:0] c
);
  
reg signed [31:0] q;
reg signed [31:0] r;

// TODO: If one of the operands is negative

// a / b = c

// If you need help translating:
// q = dividend = initally a, ends up being quotient
// m = divisor = b
// r = A, ends up being remainder

r = 31'b0; // init A to 0
q = a;
assign neg_b = {~b[31], ~b} + 1; // 2s Complement of b
always @(a or b) begin
  for(i = 0; i < 32; i = i + 1)
    r = {r << 1, q[31]}; // Shift A 1 binary position, and then set least significant bit to most significant bit of q
    q = q << 1; // Shift Q 1 binary position
    r = r[31] == 1'b0 ? r + neg_b : r + b; // A is positive ? A - M : A + M
    q = r[31] == 1'b0 ? {q[31:1], 1'b1} : {q[31:1], 1'b0}; // A is positive ? q[0] == 1 : q[1] == 0
  end
  r = r[31] == 1'b1 ? r + b : r; // If A < 0, add M once more
end
assign c = {q, r}; // Top 32 bits quotient, bottom 32 bits remainder
endmodule