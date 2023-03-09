module CONFF_logic (
    input [1:0] C2bits, input signed [31:0] bus, input CONin, output CONout
);
    
wire [1:0] decoderInput;
wire [3:0] decoderOutput;
wire busNOR brFlag;

assign busNOR = ~|bus; // unless all bits are 1 it will be 0

assign decoderInput = C2bits;
2_to_4_decoder decoder(decoderInput,decoderOutput);
//Temp wires
wire brZero, brNonZero, brPositive, brNegative;

//Temp wires used for branchFlags
assign brZero = busNOR & decoderOutput[0];
assign brNonZero = !busNOR & decoderOutput[1];
assign brPositive = !bus[31] & decoderOutput[2];
assign brPositive = bus[31] & decoderOutput[3];
assign brFlag = brZero | brNonZero | brPositive | brNegative;

//Essentially holds flag until the CONin is asserted
dFF CON(.clk(CONin), .D(brFlag), .Q(CONout));
endmodule
