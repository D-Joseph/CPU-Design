module rotateLeft (
    input wire [31:0] a,
    input wire [4:0] shift_amount,
    output reg [31:0] y
);

assign y = {a[31:shift_amount], a[shift_amount-1:0]};

endmodule
