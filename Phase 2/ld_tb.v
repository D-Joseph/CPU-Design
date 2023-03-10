`timescale 1ns / 10ps
module ld_tb; 	
	reg clk, clr;
	reg IncPC, CONin; 
	reg [31:0] Mdatain;
	wire [31:0] bus_contents;
	reg RAM_write, MDRin, MDRout, MARin, IR_enable;
	reg Read;
	reg R_enable, Rout;
	reg [15:0] R0_R15_in, R0_R15_out;
	reg Gra, Grb, Grc;
	reg HI_enable, LO_enable, ZHighIn, ZLowIn, Y_enable, PC_enable, InPort_enable, OutPort_enable;
	reg InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout;
	wire [4:0] opcode;
	wire[31:0] OutPort_output;
	reg [31:0] InPort_input;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
reg	[3:0] Present_state= Default;


CPUDesignProject DUT(PCout, Zlowout, MDRout,R2out, R3out, MARin,ZLowIn, PCin, MDRin, IRin, Yin, IncPC,Read,
			AND, R1in, R2in, R3in,Clock, Mdatain,ZLowContents);
// add test logic here 
initial  
    begin 
       Clock = 0; 
       forever #10 Clock = ~ Clock; 
end 
 
always @(posedge Clock)  // finite state machine; if clock rising-edge 
   begin 
      case (Present_state) 
       Default			:	#40  Present_state = T0;
		T0					:	#40  Present_state = T1;
		T1					:	 #40 Present_state = T2;
		T2					:	#40  Present_state = T3;
		T3					:	#40  Present_state = T4;
		T4					:	 #40 Present_state = T5;
		T5					:	 #40 Present_state = T6;
		T6					:	 #40 Present_state = T7;
       endcase 
   end   
                                                          
always @(Present_state)  // do the required job in each state 
begin 
    case (Present_state)               // assert the required signals in each clock cycle 
        Default: begin 
              		PCout <= 0;   Zlowout <= 0;   MDRout<= 0;   //initialize the signals
					   MARin <= 0;  ZLowIn <= 0; ZHighIn <= 0;  CONin <= 0
						PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
						IncPC <= 0;   Read <= 0;   MDRout <= 0
					    Mdatain <= 32'h00000000; Gra <= 0; Grb <= 0; Grc <= 0;
                        BAout <= 0; Cout <= 0; R_enable <= 0;
        end 

 
         T0: begin                                                                                  // see if you need to de-assert these signals 
				 PCout <= 1; MARin <= 1; IncPC <= 1; ZLowIn <= 1; 

				  //Deassert the signals before the next step
        end 
			T1: begin
                PCout <= 0; MARin <= 0; IncPC <= 0; ZLowIn <= 0;
                
                Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1;
            end
            T2: begin
                Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;

                MDRout<= 1; IRin <= 1;
				
            end
            T3: begin
                MDRout <= 0; IRin <= 0;
                
                Grb <= 1; BAout <= 1; Yin <= 1;
                
            end
            T4: begin
                Grb <= 0; BAout <= 0; Yin <= 0;

                Cout <= 1; ZHighIn <= 1; ZLowIn <= 1;
            end
            T5: begin
                Cout <= 0; ZHighIn <= 0; ZLowIn <= 0;
                
                Zlowout<= 1; MARin <= 1; 
				end
            T6: begin
               Zlowout<= 0; MARin <= 0; 
               Read <= 1; MDRin <= 1;
                
			end
            T7: begin
                Read <= 0; MDRin <= 0;
                
                MDRout <= 1; Gra <= 1; R_enable <= 1; 
    
			end
    endcase 
end 
endmodule  