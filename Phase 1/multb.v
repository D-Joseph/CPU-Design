module booth_multiplier_tb;

reg [31:0] multiplicand;
reg [31:0] multiplier;
wire [63:0] product;

booth_multiplier bm (
    .multiplicand(multiplicand),
    .multiplier(multiplier),
    .product(product)
);

initial begin
    multiplicand = 32'b10;
    multiplier = 32'b11;
    #100 $display("product = %d", product);
end

endmodule