module 4_to_16_encoder (
    input [3:0] decoderInput,
    output [15:0] decoderOutput
);

always @(*) begin
    decoderOutput = 15'b0000000000000001 << decoderInput;
end
    
endmodule