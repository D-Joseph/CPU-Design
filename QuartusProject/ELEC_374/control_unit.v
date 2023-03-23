`timescale 1ns/10ps
module control_unit (
	output reg IncPC, CONin, ramWE, MDRin, MDRout, MARin, IRin,Read, Rin, Rout, Gra, Grb, Grc, 
	HIin, LOin, ZHighIn, ZLowIn, Yin, PCin, InPort_enable, OutPort_enable,
	InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout, run,
	output reg [15:0] R_enableIn,
	input [31:0] IR,
	input clk, rst, stop
	);
 

parameter reset_state= 8'b00000000, fetch0 = 8'b00000001, fetch1 = 8'b00000010, fetch2= 8'b00000011,
			 add3 = 8'b00000100, add4= 8'b00000101, add5= 8'b00000110, sub3 = 8'b00000111, sub4 = 8'b00001000, sub5 = 8'b00001001,
			 mul3 = 8'b00001010, mul4 = 8'b00001011, mul5 = 8'b00001100, mul6 = 8'b00001101, div3 = 8'b00001110, div4 = 8'b00001111,
			 div5 = 8'b00010000, div6 = 8'b00010001, or3 = 8'b00010010, or4 = 8'b00010011, or5 = 8'b00010100, and3 = 8'b00010101, 
			 and4 = 8'b00010110, and5 = 8'b00010111, shl3 = 8'b00011000, shl4 = 8'b00011001, shl5 = 8'b00011010, shr3 = 8'b00011011,
			 shr4 = 8'b00011100, shr5 = 8'b00011101, rol3 = 8'b00011110, rol4 = 8'b00011111, rol5 = 8'b00100000, ror3 = 8'b00100001,
			 ror4 = 8'b00100010, ror5 = 8'b00100011, neg3 = 8'b00100100, neg4 = 8'b00100101, neg5 = 8'b00100110, not3 = 8'b00100111,
			 not4 = 8'b00101000, not5 = 8'b00101001, ld3 = 8'b00101010, ld4 = 8'b00101011, ld5 = 8'b00101100, ld6 = 8'b00101101, 
			 ld7 = 8'b00101110, ldi3 = 8'b00101111, ldi4 = 8'b00110000, ldi5 = 8'b00110001, st3 = 8'b00110010, st4 = 8'b00110011,
			 st5 = 8'b00110100, st6 = 8'b00110101, st7 = 8'b00110110, addi3 = 8'b00110111, addi4 = 8'b00111000, addi5 = 8'b00111001,
			 andi3 = 8'b00111010, andi4 = 8'b00111011, andi5 = 8'b00111100, ori3 = 8'b00111101, ori4 = 8'b00111110, ori5 = 8'b00111111,
			 br3 = 8'b01000000, br4 = 8'b01000001, br5 = 8'b01000010, br6 = 8'b01000011, br7 = 8'b11111111, jr3 = 8'b01000100, jal3 = 8'b01000101, 
			 jal4 = 8'b01000110, mfhi3 = 8'b01000111, mflo3 = 8'b01001000, in3 = 8'b01001001, out3 = 8'b01001010, nop3 = 8'b01001011, 
			 halt3 = 8'b01001100,fetch2a = 8'b10000000, fetch3 = 8'b11000000; 
 
reg [7:0] present_state = reset_state;  // adjust the bit pattern based on the number of states

always @(posedge clk, posedge rst, posedge stop) // finite state machine; if clock or reset rising-edge
 begin
 if (rst == 1'b1)
	present_state = reset_state;
 if (stop == 1'b1) 
	present_state = halt3;
 else case (present_state)
	reset_state : present_state = fetch0;
	fetch0 : present_state = fetch1;
	fetch1 : present_state = fetch2;
	fetch2			:	present_state = fetch2a;
			fetch2a			:	present_state = fetch3;
			fetch3			:	begin	
					case (IR[31:27]) // inst. decoding based on the opcode to set the next state
						5'b00011 : present_state = add3; // this is the add instruction
						5'b00100 : present_state = sub3;
						5'b00101 : present_state = and3;
						5'b00110 : present_state = or3;
						5'b01111 : present_state = mul3;
						5'b10000 : present_state = div3;
						5'b01001 : present_state = shl3;
						5'b00111 : present_state = shr3;
						5'b01011 : present_state = rol3;
						5'b01010 : present_state = ror3;
						5'b10001 : present_state = neg3;
						5'b10010 : present_state = not3;
						5'b00000 : present_state = ld3;
						5'b00001 : present_state = ldi3;
						5'b00010 : present_state = st3;
						5'b01100 : present_state = addi3;
						5'b01101 : present_state = andi3;
						5'b01110 : present_state = ori3;
						5'b10011 : present_state = br3;
						5'b10100 : present_state = jr3;
						5'b10101 : present_state = jal3;
						5'b11000 : present_state = mfhi3;
						5'b11001 : present_state = mflo3;
						5'b10110 : present_state = in3;
						5'b10111 : present_state = out3;
						5'b11010 : present_state = nop3;
						5'b11011 : present_state = halt3;
					endcase
				end
			add3				: 	present_state = add4;
			add4				:	present_state = add5;
			add5 				:	present_state = reset_state;
			
			addi3				: 	present_state = addi4;
			addi4				:	present_state = addi5;
			addi5 			:	present_state = reset_state;
			
			sub3				: 	present_state = sub4;
			sub4				: 	present_state = sub5;
			sub5				:	present_state = reset_state;
			
			mul3				: 	present_state = mul4;
			mul4				: 	present_state = mul5;
			mul5				: 	present_state = mul6;
			mul6           :	present_state = reset_state; 
			
			div3				: 	present_state = div4;
			div4				: 	present_state = div5;
			div5				: 	present_state = div6;
			div6				:	present_state = reset_state;
			
			or3				: 	present_state = or4;
			or4				: 	present_state = or5;
			or5				:	present_state = reset_state;
			
			and3				: 	present_state = and4;
			and4				: 	present_state = and5;
			and5   			:	present_state = reset_state;
			
			shl3				: 	present_state = shl4;
			shl4				: 	present_state = shl5;
			shl5 				:	present_state = reset_state;
			
			shr3				: 	present_state = shr4;
			shr4				: 	present_state = shr5;
			shr5 				:	present_state = reset_state;
			
			rol3				: 	present_state = rol4;
			rol4				: 	present_state = rol5;
			rol5 				:	present_state = reset_state;
			
			ror3				: 	present_state = ror4;
			ror4				: 	present_state = ror5;
			ror5 				:	present_state = reset_state;
			
			neg3				: 	present_state = neg4;
			neg4				: 	present_state = reset_state;
			
			not3				: 	present_state = not4;
			not4				: 	present_state = reset_state;
			
			ld3				: 	#40 present_state = ld4;
			ld4				: #40 	present_state = ld5;
			ld5				: #40 	present_state = ld6;
			ld6				: 	#40 present_state = ld7;
			ld7				:   present_state = reset_state;
			
			ldi3				: 	present_state = ldi4;
			ldi4				: 	present_state = ldi5;
			ldi5 				:	present_state = reset_state;
			
			st3				: 	present_state = st4;
			st4				: 	present_state = st5;
			st5				: 	present_state = st6;
			st6				: 	present_state = st7;
			st7 				:	present_state = reset_state;
			
			andi3				: 	present_state = andi4;
			andi4				: 	present_state = andi5;
			andi5 			:	present_state = reset_state;
			
			ori3				: 	present_state = ori4;
			ori4				: 	present_state = ori5;
			ori5 				:	present_state = reset_state;
			
			jal3				: 	present_state = jal4;
			jal4 				:	present_state = reset_state;
			
			jr3 				:	present_state = reset_state;
			
			br3				: 	present_state = br4;
			br4				: 	present_state = br5;
			br5				: 	present_state = br6;
			br6  				:	present_state = br7;
			br7  				:	present_state = reset_state;
			
			out3 				:	present_state = reset_state;
			
			in3 				:	present_state = reset_state;
			
			mflo3 			:	present_state = reset_state;
			
			mfhi3 			:	present_state = reset_state;
			
			nop3 				:	present_state = reset_state;
	endcase
 end
always @(present_state) begin // do the job for each state
	case (present_state) // assert the required signals in each state
		reset_state: begin
			run <= 1;
			R_enableIn <= 0;
			PCout <= 0; ZLowout <= 0; MDRout <= 0; 
				MARin <= 0; ZHighIn <= 0; ZLowIn <= 0; CONin<=0; 
				InPort_enable<=0; OutPort_enable<=0;
				PCin <=0; MDRin <= 0; IRin <= 0; 
				Yin <= 0; IncPC <= 0; ramWE <=0;
				Gra<=0; Grb<=0; Grc<=0; BAout<=0; Cout<=0;
				InPortout<=0; ZHighout<=0; LOout<=0; HIout<=0; 
				HIin<=0; LOin<=0; Rout<=0; Rin<=0; Read<=0; 
			
		end
      fetch0: begin                                                                                  // see if you need to de-assert these signals 
				PCout <= 1; MARin <= 1; 
      end 
		fetch1: begin
				PCout <= 0; MARin <= 0; ZLowIn <= 0; 
            Read <= 1; MDRin <= 1; //This is essentially (copy zlow back into pc)
      end
      fetch2: begin
            ZLowout <= 0; Read <= 0; MDRin <= 0;
            MDRout <= 1; IRin <= 1; 
		end		
		fetch2a : begin
		
		end
		fetch3 : begin
				MDRout <= 0; IRin <= 0;
				PCin <= 1; IncPC <= 1;   
		end
		//END OF FETCH
		add3, sub3, or3, and3, shl3, shr3, rol3, ror3: begin
			 PCin <= 0; IncPC <= 0;  
			 Grb <= 1; Rout <= 1;Yin <= 1;
		end
		add4, sub4, or4, and4, shl4, shr4, rol4, ror4: begin
          Grb <= 0; Rout <= 0;Yin <= 0;
			 Grc <= 1; Rout <= 1; ZLowIn <= 1; ZHighIn <= 1; 
      end
      add5, sub5, or5, and5, shl5, shr5, rol5, ror5: begin
          Grc <= 0; Rout <= 0; ZLowIn <= 0; ZHighIn <= 0;
			 ZLowout<= 1; Gra <= 1; Rin <= 1; 
			//#40 Zlowout<= 0; Gra <= 0; Rin <= 0; 
		end
		
		mul3, div3 : begin
			  PCin <= 0; IncPC <= 0;  
			 Gra <= 1; Rout <= 1;Yin <= 1;
	   end
		mul4, div4: begin
			 Gra <= 0; Rout <= 0;Yin <= 0;
			 Grb <= 1; Rout <= 1; ZLowIn <= 1; ZHighIn <= 1; 
		end
		mul5, div5: begin
			 Grb <= 0; Rout <= 0; ZLowIn <= 0; ZHighIn <= 0; 
			 ZLowout<= 1; LOin <= 1;
		end
		mul6, div6: begin
			 ZLowout<= 1; LOin <= 1;
			 ZHighout <= 1; HIin <= 1;
			 //#40 Zhighout <= 0; HIin <= 0;
		end
		
		andi3,ori3,addi3: begin
            PCin <= 0; IncPC <= 0;  
           Grb <= 1; Rout <= 1; Yin <= 1;     
      end
      andi4,ori4,addi4: begin
           Grb <= 0; Rout <= 0; Yin <= 0;
           Cout <= 1; ZHighIn <= 1; ZLowIn <= 1;
      end
      andi5,ori5,addi5: begin
            Cout <= 0; ZHighIn <= 0; ZLowIn <= 0; 
            ZLowout<= 1; Gra <= 1; Rin <= 1; 
			   //#40 ZLowout<= 0; Gra <= 0; Rin <= 0; 
		end
		
      not3,neg3: begin
             PCin <= 0; IncPC <= 0;  
				Grb <= 1; Rout <= 1; ZLowIn <= 1;
      end
      not4,neg4: begin
            Grb <= 0; Rout <= 0;Yin <= 0;
				ZLowout<= 1; Gra <= 1; Rin <= 1; 
	   end
		
		ld3: begin
             PCin <= 0; IncPC <= 0; 
            Grb <= 1; BAout <= 1; Yin <= 1;   
      end
      ld4: begin
            Grb <= 0; BAout <= 0; Yin <= 0;
            Cout <= 1; ZHighIn <= 1; ZLowIn <= 1;
      end
      ld5: begin
            Cout <= 0; ZHighIn <= 0; ZLowIn <= 0;
            ZLowout<= 1; MARin <= 1; 
		end
      ld6: begin
            ZLowout<= 0; MARin <= 0; 
            Read <= 1; MDRin <= 1;
		end
      ld7: begin
            Read <= 0; MDRin <= 0;
            MDRout <= 1; Gra <= 1; Rin <= 1; 
		end
		
		ldi3: begin
            PCin <= 0; IncPC <= 0; 
            Grb <= 1; BAout <= 1; Yin <= 1;   
      end
      ldi4: begin
            Grb <= 0; BAout <= 0; Yin <= 0;
            Cout <= 1; ZHighIn <= 1; ZLowIn <= 1;
      end
      ldi5: begin
            Cout <= 0; ZHighIn <= 0; ZLowIn <= 0;
            ZLowout<= 1; Gra <= 1; Rin <= 1; 
		end
		
		st3: begin
            PCin <= 0; IncPC <= 0; 
           Grb <= 1; BAout <= 1; Yin <= 1;  
      end
		st4: begin
			  Grb <= 0; BAout <= 0; Yin <= 0;
           Cout <= 1; ZHighIn <= 1; ZLowIn <= 1;
		end
		st5: begin
           Cout <= 0; ZHighIn <= 0; ZLowIn <= 0;
           ZLowout<= 1; MARin <= 1; 
		end
		st6: begin
           ZLowout<= 0; MARin <= 0; 
           Read <= 0; Gra <= 1; Rout <= 1;  MDRin <= 1;    
		end
		st7: begin
           Gra <= 0; Rout <= 0;  MDRin <= 0; MDRout <= 1;
			  ramWE <= 1;
		end
		
		jr3: begin
           PCin <= 0; IncPC <= 0; 
           Gra <= 1; Rout <= 1; PCin <= 1;
			  #40 PCin <= 0;
      end
		
		jal3: begin
            PCin <= 0; IncPC <= 0; 
           PCout <= 1; R_enableIn <= 16'h8000;
      end
		jal4: begin
           PCout <= 0; R_enableIn <= 16'h0;
           Gra <= 1; Rout <= 1; PCin <= 1;
      end
		
		out3: begin
            PCin <= 0; IncPC <= 0; 
           Gra <= 1; Rout <= 1; OutPort_enable <= 1;
      end
		
		in3: begin
           PCin <= 0; IncPC <= 0; 
           Gra <= 1; Rin <= 1; InPortout <= 1;
	   end
		
		mfhi3: begin
            PCin <= 0; IncPC <= 0; 
           Gra <= 1; Rin <= 1; HIout <= 1;
      end
		
		mflo3: begin
            PCin <= 0; IncPC <= 0; 
           Gra <= 1; Rin <= 1; LOout <= 1;
      end
		
		br3: begin
           PCin <= 0; IncPC <= 0; 
           Gra <= 1; Rout <= 1; CONin <= 1;
      end
      br4: begin
			  Gra <= 0; Rout <= 0; CONin <= 0;
			  PCout <= 1; Yin <= 1; 
      end
		br5: begin
			  PCout <= 0; Yin <= 0; 
           Cout <= 1; ZLowIn <= 1; ZHighIn <= 1;
		end
      br6: begin
           Cout <= 0; ZLowIn<= 0; ZHighIn <= 0; 
			  ZLowout <= 1; PCin <= 1;     
		end
      br7: begin
           ZLowout<=0; PCin<=0;
			  PCout<=1; MARin <= 1;
		end
		halt3: begin
		run <= 0;
		end
	endcase
	end
endmodule