module division_32_bit(input wire signed [31:0] a, b, output reg signed[63:0] z);

reg signed [31:0] quotient, remainder, valueToSub;
reg [5:0] count;

always @(*) begin
    quotient = 32'b0;
    remainder = 32'b0;
    valueToSub = b;
    count = 6'b0;
    
    if(a[31] == 1) begin
        remainder = -a;
    end else begin
        remainder = a;
    end
    
    if(b[31] == 1) begin
        valueToSub = -b;
    end
    
    while(count < 6) begin
        valueToSub = valueToSub >>> 1;
        count = count + 1;
    end
    
    count = 6'b0;
    
    while(count < 32) begin
        remainder = remainder << 1;
        quotient = quotient << 1;
        quotient[0] = quotient[0] | (remainder[31] ^ valueToSub[31]);
        remainder = remainder - valueToSub;
        
        if(remainder[31] == 1) begin
            remainder = remainder + valueToSub;
            quotient[0] = quotient[0] ^ 1;
        end else begin
            valueToSub = valueToSub >> 1;
        end
        
        count = count + 1;
    end
    
    z = {remainder,quotient};
end

endmodule
