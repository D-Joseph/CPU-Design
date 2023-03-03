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
			if(a[31] == 1) 
				a = a + m;
      else if(a[31] == 0) 
        a = a - m;
    
			if(a[31] == 1) 
				q[0] = 0;
      else 
        q[0] = 1;
    end

	  if(a[31] == 1)  //only restore at end
			a = a + m;
		
		if(dividend[31] == 1)  //if input is negative, negate the output
		  q = -q;
		
    c = {a,q};
  end 
endmodule

