module selectencodelogic (
    input [31:0] instruction,
    input Gra, Grb, Grc, Rin, Rout, BAout,
    output [31:0] C_Sign_Extended,
    output [15:0] RegInSel, RegOutSel,
    output [4:0] opcode
);

    wire [15:0] decoderOutput;
    wire [3:0] decoderInput;
    assign decoderInput = (instruction[26:23]&{4{Gra}}) | (instruction[22:19]&{4{Grb}}) | (instruction[18:15]&{4{Grc}});
    
    encoder_4_to_16 encoder(decoderInput, decoderOutput);

    assign opcode = instruction[31:27];
    assign RegOutSel = decoderOutput & ({16{Rout}}|{16{BAout}});
    assign RegInSel = {16{Rin}} & decoderOutput;
    assign C_Sign_Extended = {{13{instruction[18]}},instruction[18:0]}; //fanning out the msb of C
endmodule