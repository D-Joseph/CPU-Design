`timescale 1ns / 10ps
module and_tb; 	
	reg PCout, Zlowout, MDRout, R2out, R3out, MARin, Zin, PCin, MDRin, IRin, Yin, IncPC, Read;
   reg AND;
	reg R1in, R2in, R3in;
	reg Clock;
	reg [31:0] Mdatain;
	wire [31:0] R1_out;

parameter	Default = 4'b0000, Reg_load1a= 4'b0001, Reg_load1b= 4'b0010,
					Reg_load2a= 4'b0011, Reg_load2b = 4'b0100, Reg_load3a = 4'b0101,
					Reg_load3b = 4'b0110, T0= 4'b0111, T1= 4'b1000,T2= 4'b1001, T3= 4'b1010, T4= 4'b1011, T5= 4'b1100;
reg	[3:0] Present_state= Default;


CPUDesignProject DUT(PCout, Zlowout, MDRout, R2out, R3out, MARin,Zin, PCin, MDRin, IRin, Yin, IncPC,Read,
			AND, R1in, R2in, R3in,Clock, Mdatain,R1_out);
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
		T0					:	#40 Present_state = T1;
		T1					:	#40 Present_state = T2;
		T2					:	#40 Present_state = T3;
		T3					:	#40 Present_state = T4;
		T4					:	#40 Present_state = T5;
       endcase 
   end   
                                                          
always @(Present_state)  // do the required job in each state 
begin 
    case (Present_state)               // assert the required signals in each clock cycle 
        Default: begin 
              		PCout <= 0;   Zlowout <= 0;   MDRout<= 0;   //initialize the signals
					 R2out <= 0;   R3out <= 0;   MARin <= 0;   Zin <= 0;  
						PCin <=0;   MDRin <= 0;   IRin  <= 0;   Yin <= 0;  
						IncPC <= 0;   Read <= 0;   AND <= 0;  
						R1in <= 0; R2in <= 0; R3in <= 0; Mdatain <= 32'h00000000;
        end 
        Reg_load1a: begin   
                        Mdatain <= 32'h00000012; 
                        Read = 0; MDRin = 0;                   // the first zero is there for completeness 
                        #10 Read <= 1; MDRin <= 1;   
                        #15 Read <= 0; MDRin <= 0;    
        end 
        Reg_load1b: begin  
                        #10 MDRout <= 1; R2in <= 1;   
                        #15 MDRout <= 0; R2in <= 0;     // initialize R2 with the value $12          
        end 
        Reg_load2a: begin   
                       Mdatain <= 32'h00000014; 
								#10 Read <= 1; MDRin <= 1;   
								#15 Read <= 0; MDRin <= 0;       
        end 
        Reg_load2b: begin  
                       #10 MDRout <= 1; R3in <= 1;   
                       #15 MDRout <= 0; R3in <= 0;  // initialize R3 with the value $14         
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
              PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;   
        end 
        T1: begin 
              Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;   
              Mdatain <= 32'h28918000;       // opcode for and R1, R2, R3
        end 
        T2: begin 
              MDRout <= 1; IRin <= 1;
        end 
        T3: begin 
              R2out <= 1; Yin <= 1;    
        end 
        T4: begin 
              R3out <= 1; AND <= 1; Zin <= 1;    
        end 
        T5: begin 
              Zlowout <= 1; R1in <= 1; 
				  //R1_out <= 1;
        end 
    endcase 
end 
endmodule  