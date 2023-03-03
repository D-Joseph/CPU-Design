module rotate_left_32_bit(input wire [31:0] in, input wire[4:0] b, output reg [31:0] out);
	integer bitsToRotate;
	always@(*) begin
		bitsToRotate = b;
		//First shift the bits left by number of bits to rotate
		//Then shift the bits by 32- the number of bits. 
		//This essentially leaves you only the bits that need to be rotated around, at the rightmost bits
		//Then or both results to get the final result 
		out = (in << bitsToRotate) | (in >> (32-bitsToRotate));
	end   
endmodule 