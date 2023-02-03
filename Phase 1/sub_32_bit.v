module  sub_32_bit (
    input wire [31:0] a , b,
    input wire cin,
    output wire cout,
    output wire [31:0] sum
);
//to subtract, you need to negate the second number, then add it to first
wire [31:0] temp;

negate_32_bit NEG(.a(b),.y(temp));
adder_32_bit ADD(.a(a),.b(temp),.cin(cin),.cout(cout),.sum(sum))


    
endmodule