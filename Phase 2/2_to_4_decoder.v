module 2_to_4_encoder (
    input [1:0] decoderInput,
    output [3:0] decoderOutput
);

always @(*) begin
    decoderOutput = 4'0001 << decoderInput;
end
    
endmodule