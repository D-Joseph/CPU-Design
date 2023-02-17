module division_32_bit(
    input signed [31:0] a,
    input signed [31:0] b,
    output [63:0] z
);

reg signed [31:0] absA, absB;
reg signed [31:0] q;
reg signed [31:0] r;

always @ (*) begin
    if(a[31] == 1'b1) begin
		absA = -a;
		q = absA / b;
		q = -q;
		r = absA % b;
	 end else if(b[31] == 1'b1) begin
		absB = -b;
		q = absA / b;
		q = -q;
		r = absA % b;
	  end
	  else begin
		q = a / b;
		r = a % b;
	  end
end

assign z = {r, q};

endmodule
