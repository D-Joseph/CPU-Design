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
  for(i = 0; i < 32; i = i + 1) begin
    r = {r << 1, q[31]}; // Shift A 1 binary position, and then set least significant bit to most significant bit of q
    q = q << 1; // Shift Q 1 binary position
    r = r[31] == 1'b0 ? r + neg_b : r + b; // A is positive ? A - M : A + M
    q = r[31] == 1'b0 ? {q[31:1], 1'b1} : {q[31:1], 1'b0}; // A is positive ? q[0] == 1 : q[1] == 0
  end
  r = r[31] == 1'b1 ? r + b : r; // If A < 0, add M once more
end
assign c = {q, r}; // Top 32 bits quotient, bottom 32 bits remainder
endmodule



module division_32_bit (
  input wire [31:0] a,
  input wire [31:0] b,
  output reg [63:0] c
);
  
reg signed [31:0] q;
reg signed [31:0] r;
reg signed [31:0] neg_b;
integer i;

// TODO: If one of the operands is negative

// a / b = c

// If you need help translating:
// q = dividend = initally a, ends up being quotient
// m = divisor = b
// r = A, ends up being remainder
 // 2s Complement of b

always @(a or b) begin
	r = 31'b0; // init A to 0
	q = a;
	neg_b = -b; 
 for(i = 0; i < 32; i = i + 1) begin
    r = {r << 1, q[31]}; // Shift A 1 binary position, and then set least significant bit to most significant bit of q
    q = q << 1; // Shift Q 1 binary position
    r = r[31] == 1'b0 ? r + neg_b : r + b; // A is positive ? A - M : A + M
    q = r[31] == 1'b0 ? {q[31:1], 1'b1} : {q[31:1], 1'b0}; // A is positive ? q[0] == 1 : q[1] == 0
  end
  r = r[31] == 1'b1 ? r + b : r; // If A < 0, add M once more
    c = {q, r}; // Top 32 bits quotient, bottom 32 bits remainder

end
endmodule


nteger i;
integer flagBit = 0;
integer index = 0;
always@(*) begin
for (i = 31; i >= 0; i = i - 1) begin
  if (a[i] && flagBit == 0) begin
    index = i;
    flagBit = 1;
  end
  $display(index);
end
end

module division_32_bit (
  input  [31:0] a,
  input  [31:0] b,
  output reg [63:0] c
);

reg  [31:0] A;
reg  [31:0] Q;
reg  [31:0] M;
integer bitCount;
wire counter;


always @(*) begin
  A = 0;
  Q = a;
  M = b;
  for(bitCount = 3; bitCount >= 0; bitCount = bitCount -1) begin
	  A = {A << 1, Q[3]};
	  Q = Q << 1;
	  A = A - M;
	  Q[0] = (A[3] == 1'b1) ? 0 : 1;
	  if(A[3] == 1'b1) begin
			A = A + M;
	  end
  end
 c = {Q, A};
 //quotient = Q;
	//remainder = A;
end

endmodule


`timescale 1ns / 1ps

module division_32_bit(input [31:0] dividend, divisor, output reg [63:0] c);
    reg [31:0] m, q;
    reg [32:0] a;
    integer i;
   	//In this algorithm, we first convert all negative inputs to positive to perform division 
    always @ (*) begin
      if(A[31] == 1) 
			  q = -dividend;
		  else 
			  q = dividend;
		  
      m = divisor;
      a = 0;

      for(i = 0; i < 32; i = i+1) begin
        a = {a[30:0], q[31]};
        q[31:1] = q[30:0];
				a = a - m;
        if(a[31] == 1) begin //restoring portion of algorithm
          q[0] = 0;
          a = a + m;
        end
        else 
          q[0] = 1;
      end

      if(dividend[31] == 1)  //if input is negative, negate the output
		    q = -q;

      c = {a,q}; 
    end 
endmodule

