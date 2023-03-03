module selectencodelogic (
    input [31:0] instruction,
    input Gra, Grb, Grc, Rin, Rout, BAout,
    output [31:0] C_Sign_Extended,
    output [15:0] RegIn, RegOut,
    output [4:0] opcode,
    output wire [3:0] decoderInput
);

    wire [15:0] decoderOutput;
    assign decoderInput = (instruction[26:23]&{4{Gra}}) | (instruction[22:19]&{4{Grb}}) | (instruction[18:15]&{4{Grc}})
    
    4_to_16_encoder decoder(decoderInput, decoderOutput);

    assign opcode = instruction[31:27];
    assign C
endmodule