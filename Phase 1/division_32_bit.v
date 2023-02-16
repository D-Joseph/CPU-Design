module division(
	input signed [31:0] dividend, divisor,
   output reg [63:0] z
);

    reg [63:32] high;
    reg [31:0] low;

    always @ (*) //any signal change
    begin
        high = dividend % divisor; //store the remainder in the high register
        low  = (dividend - high) / divisor;   // subtract the remainder from the dividend, then divide it by the divisor
        begin
          z = {high, low}; // concatenate the high and low registers into a 64 bit output reg
        end
    end
    
endmodule
