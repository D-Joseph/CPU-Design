`timescale 1ns / 1ps

module division_32_bit(input [31:0] A, b, output reg [63:0] c);
	 reg [31:0] m, q;
    reg [32:0] a;
    integer i;
	 

    always @ (*)begin
        begin
        if(A[31] == 1) begin
			q = -A;
		  end else begin
			q = A;
		  end
		  //q = A;
        m = b;
        a = 0;
        for(i = 0; i < 32; i = i+1)
        begin
            a = {a[30:0], q[31]};
            q[31:1] = q[30:0];
				if(a[31] == 1) begin
					a = a + m;
				end
            else if(a[31] == 0)begin
                a = a - m;
            end
				
				if(a[31] == 1) begin
					q[0] = 0;
				end
            else begin
                q[0] = 1;
            end
        end
		  if(a[31] == 1) begin
			a = a + m;
		  end
		  if(A[31] == 1) begin
		  q = -q;
		  end
        c = {a,q};
        end
    end 

endmodule

