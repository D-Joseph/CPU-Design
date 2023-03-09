module encoder_2_to_4(
    input [1:0] decoderInput,
    output reg [3:0] decoderOutput
);

always @(*) begin
    decoderOutput = 4'b0001 << decoderInput;
end
    
endmodule