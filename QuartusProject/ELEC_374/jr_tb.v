`timescale 1ns / 10ps
module jr_tb; 	
	reg clk, clr;
	reg IncPC, CONin; 
	reg [31:0] Mdatain;
	wire [31:0] bus_contents;
	reg ramWE, MDRin, MDRout, MARin, IRin,Read;
	reg Rin, Rout;
	reg [15:0] R0_R15_in, R0_R15_out;
	reg Gra, Grb, Grc;
	reg HIin, LOin, ZHighIn, ZLowIn, Yin, PCin, InPort_enable, OutPort_enable;
	reg InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout;
	wire [4:0] opcode;
	wire[31:0] outport_data_out;
	reg [31:0] inport_data_in;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
reg	[3:0] Present_state= Default;


CPUDesignProject DUT(.PCout(PCout),.ZHighout(ZHighout),.ZLowout(ZLowout),.MDRout(MDRout), 
			.MARin(MARin), .MDRin(MDRin),.PCin(PCin),.IRin(IRin),
			.Yin(Yin),.IncPC(IncPC),.Read(Read),.clk(clk),.MDatain(Mdatain), 	
			.clr(clr),.HIin(HIin),.LOin(LOin),.HIout(HIout),.LOout(LOout),                		
			.ZHighIn(ZHighIn),.ZLowIn(ZLowIn),.Cout(Cout),.ramWE(ramWE),
			.Gra(Gra),.Grb(Grb),.Grc(Grc),.R_in(Rin),.R_out(Rout),	.BAout(BAout),
			.CONin(CONin),.R_enableIn(R0_R15_in), .Rout_in(R0_R15_out),
			.OutPortIn(OutPort_enable),.InPortIn(InPort_enable),
			.InPortout(InPortout), .inport_data_in(inport_data_in),
			.outport_data_out(outport_data_out),.bus_contents(bus_contents),
			.operation(opcode)	
			);
// add test logic here 
initial  
    begin 
       clk = 0; 
       forever #10 clk = ~ clk; 
end 
 
always @(posedge clk)  // finite state machine; if clock rising-edge 
   begin 
      case (Present_state) 
       Default			:	#40  Present_state = T0;
		T0					:	#40  Present_state = T1;
		T1					:	 #40 Present_state = T2;
		T2					:	#40  Present_state = T3;
       endcase 
   end   
                                                          
always @(Present_state)  // do the required job in each state 
begin 
    case (Present_state)               // assert the required signals in each clock cycle 
        Default: begin 
              PCout <= 0; ZLowout <= 0; MDRout <= 0; 
				MARin <= 0; ZHighIn <= 0; ZLowIn <= 0; CONin<=0; 
				InPort_enable<=0; OutPort_enable<=0;
				inport_data_in<=32'd0;
				PCin <=0; MDRin <= 0; IRin <= 0; 
				Yin <= 0;
				IncPC <= 0; ramWE <=0;
				Mdatain <= 32'h00000000; Gra<=0; Grb<=0; Grc<=0;
				BAout<=0; Cout<=0;
				InPortout<=0; ZHighout<=0; LOout<=0; HIout<=0; 
				HIin<=0; LOin<=0;
				Rout<=0;Rin<=0;Read<=0;
				R0_R15_in<= 16'd0; R0_R15_out<=16'd0;
        end 

 
        T0: begin                                                                                  // see if you need to de-assert these signals 
			PCout <= 1; MARin <= 1;ZLowIn <= 1;
        end 
		T1: begin
            PCout <= 0; MARin <= 0; ZLowIn <= 0; PCin <= 1; IncPC <= 1;
            ZLowout<= 1; Read <= 1; MDRin <= 1;
        end
        T2: begin
            ZLowout<= 0; Read <= 0; MDRin <= 0;PCin <= 0; IncPC <= 0;
            MDRout<= 1; IRin <= 1; 
        end
        T3: begin
            MDRout <= 0; IRin <= 0; 
            Gra <= 1; Rout <= 1; PCin <= 1;
			#40 PCin <= 0;
        end
    endcase 
end 
endmodule  