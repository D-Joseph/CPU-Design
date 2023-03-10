module dFF (
    input clk,
    input D,
    output reg Q, QBar
);

initial begin
    Q <= 0;
    QBar <= 1;
end

always @(clk) begin
    Q <= D;
    QBar <= !D;
end
    
endmodule