module encoder_4_to_16 (
    input [3:0] decoderInput,
    output reg [15:0] decoderOutput
);

always @(*) begin
    decoderOutput = 15'b0000000000000001 << decoderInput;
end
    
endmodule