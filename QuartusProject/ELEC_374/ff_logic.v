module ff_logic(
    input clk,
    input D,
    output reg Q 
);

initial begin
    Q <= 0;
end

always @(clk) begin
    Q <= D;
end
    
endmodule