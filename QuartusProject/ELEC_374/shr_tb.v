`timescale 1ns / 10ps
module shr_tb; 	
	reg PCout, Zlowout, MDRout, R3out, R5out, MARin, ZLowIn, PCin, MDRin, IRin, Yin, IncPC, Read;
   reg [4:0] SHR;
	reg R1in, R3in, R5in;
	reg Clock;
	reg [31:0] Mdatain;
	wire [31:0] MDR_output;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100;
reg	[3:0] Present_state= Default;


CPUDesignProject DUT(PCout, Zlowout, MDRout,R3out, R5out, MARin,ZLowIn, PCin, MDRin, IRin, Yin, IncPC,Read,
			SHR, R1in, R3in, R5in,Clock, Mdatain,MDR_output);
// add test logic here 
initial  
    begin 
       Clock = 0; 
       forever #10 Clock = ~ Clock; 
end 
 
always @(posedge Clock)  // finite state machine; if clock rising-edge 
   begin 
      case (Present_state) 
       Default			:	#40 Present_state = Reg_load1a;
		Reg_load1a		:	#40 Present_state = Reg_load1b;
		Reg_load1b		:	#40 Present_state = Reg_load2a;
		Reg_load2a		:	#40 Present_state = Reg_load2b;
		Reg_load2b		:	#40 Present_state = Reg_load3a;
		Reg_load3a		:	#40 Present_state = Reg_load3b;
		Reg_load3b		:	#40 Present_state = T0;
		T0					:	#40  Present_state = T1;
		T1					:	 #40 Present_state = T2;
		T2					:	#40  Present_state = T3;
		T3					:	#40  Present_state = T4;
		T4					:	 #40 Present_state = T5;
       endcase 
   end   
                                                          
always @(Present_state)  // do the required job in each state 
begin 
    case (Present_state)               // assert the required signals in each clock cycle 
        Default: begin 
              		PCout <= 0;   Zlowout <= 0;   MDRout<= 0;   //initialize the signals
					   R3out <= 0;   R5out <= 0;   MARin <= 0;   ZLowIn <= 0;  
						PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
						IncPC <= 0;   Read <= 0;   SHR <= 0;  
						R1in <= 0; R3in <= 0; R5in <= 0; Mdatain <= 32'h00000000;
        end 
        Reg_load1a: begin   
                        Mdatain <= 32'd25; 
                        Read = 0; MDRin = 0;                   // the first zero is there for completeness 
                        #10 Read <= 1; MDRin <= 1;   
                        #15 Read <= 0; MDRin <= 0;    
        end          
        Reg_load1b: begin  
                        #10 MDRout <= 1; R3in <= 1;   
                        #15 MDRout <= 0; R3in <= 0;     // initialize R2 with the value $12          
        end 
        Reg_load2a: begin   
                       Mdatain <= 32'd3; 
								#10 Read <= 1; MDRin <= 1;   
								#15 Read <= 0; MDRin <= 0;       
        end 
        Reg_load2b: begin  
                       #10 MDRout <= 1; R5in <= 1;   
                       #15 MDRout <= 0; R5in <= 0;  // initialize R3 with the value $14         
        end 
        Reg_load3a: begin   
                       Mdatain <= 32'h00000018; 
                       #10 Read <= 1; MDRin <= 1;   
                       #15 Read <= 0; MDRin <= 0; 
        end 
        Reg_load3b: begin  
                       #10 MDRout <= 1; R1in <= 1;   
                       #15 MDRout <= 0; R1in <= 0;  // initialize R1 with the value $18           
        end 
 
         T0: begin                                                                                  // see if you need to de-assert these signals 

				  #10 PCout <= 1; MARin <= 1; IncPC <= 1; ZLowIn <= 1; 
				  #15 PCout <= 0; MARin <= 0; IncPC <= 0; ZLowIn <= 0;
				  //Deassert the signals before the next step
        end 
			T1: begin
                Zlowout<= 1; PCin <= 1; Read <= 1; MDRin <= 1;
                Mdatain <= 32'h28918000; //opcode for “and R5, R2, R4”
					 #15 Zlowout<= 0; PCin <= 0; Read <= 0; MDRin <= 0;
            end
            T2: begin
                #15 MDRout<= 1; IRin <= 1;
					 #15 MDRout <= 0; IRin <= 0;
            end
            T3: begin
                #15 R3out<= 1; Yin <= 1;
					 #15 R3out <= 0; Yin <= 0;
            end
            T4: begin
                #15 R5out<= 1; SHR <= 5'b00111; ZLowIn <= 1;
					 #15 R5out<= 0; ZLowIn <= 0;
            end
            T5: begin
                #15 Zlowout<= 1; R1in <= 1; 
					 #50 Zlowout<= 0; R1in <= 0;
				end
    endcase 
end 
endmodule  