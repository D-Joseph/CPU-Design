module adder_32_bit (
    input wire signed [31:0] a, b,
    input wire cin,
    output wire cout,
    output wire [31:0] sum
);
    wire cout1;

    CLA16 adder1(.a(a[15:0]), .b(b[15:0]), .cin(cin), .cout(cout1), .sum(sum[15:0]));
    CLA16 adder2(.a(a[31:16]), .b(b[31:16]), .cin(cout1), .cout(cout), .sum(sum[31:16]));
	 
endmodule

module CLA16 (
    input wire [15:0] a, b,
    input wire cin,
    output wire cout,
    output wire [15:0] sum
);
    //Temp wires for internal signals
    wire cout1,cout2,cout3;

    //We will now instantiate 4 of the 4 bit CLA adders that we just created below to create a 16 bit adder
    CLA4 adder1(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(cout1), .sum(sum[3:0]));
    CLA4 adder2(.a(a[7:4]), .b(b[7:4]), .cin(cout1), .cout(cout2), .sum(sum[7:4]));
    CLA4 adder3(.a(a[11:8]), .b(b[11:8]), .cin(cout2), .cout(cout3), .sum(sum[11:8]));
    CLA4 adder4(.a(a[15:12]), .b(b[15:12]), .cin(cout3), .cout(cout), .sum(sum[15:12]));
  
endmodule


module CLA4 (
    input wire [3:0] a, b,
    input wire cin,
    output wire [3:0] sum,
    output wire cout
);

	 wire [3:0] p, g, c;

    //Assign the generate and propogate terms
    assign g = a & b;
    assign p = a ^ b;

    //Assign c0 to the cin, which would be coming from the previous CLA
    assign c[0] = cin;
    //Assign the rest of the carry bits based on the generate and propagate function for a CLA
    //Source : https://www.gatevidyalay.com/carry-look-ahead-adder/
    assign c[1] = (c[0] & p[0]) | g[0];
    assign c[2] = (c[0] & p[0] & p[1]) | (g[0] & p[1]) | g[1];
    assign c[3] = (c[0] & p[0] & p[1] & p[2]) | (g[0] & p[1] & p[2]) | (g[1] & p[2]) | g[2];
    assign cout = (c[0] & p[0] & p[1] & p[2] & p[3]) | (g[0] & p[1] & p[2] & p[3]) | (g[1] & p[2] & p[3]) | (g[2] & p[3]) | g[3];

    //assign the sum
    assign sum [3:0] = p^c;

endmodule