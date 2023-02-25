module multiplication_32_bit(input wire signed [31:0] a, b, output wire signed[32*2-1:0] z);
	reg signed [2:0] cc[15:0];
	reg signed [32:0] pp[15:0];
	reg signed [63:0] spp[15:0];
	
	reg signed [63:0] product;
	reg signed [31:0] absA, absB;
	
	integer j,i;
	
	/*
	always@(a or b) begin
		if(a[31] == 1'b1) begin
			absA = -a;
			absB = b;
		end
		else if(b[31] == 1'b1) begin
			absB = -b;
			absA = a;
		end
		else begin
			absA = a;
			absB = b;
		end 
	end
	*/
	always@(*) begin
			absA = a;
			absB = b;
	end
	
	wire [32:0] inv_a;
	assign inv_a = {~absA[31], ~absA} +1;
	
	always @ (absA or absB or inv_a) 
	begin
		cc[0] = {absB[1], absB[0], 1'b0};
		
		for (j=1; j < (32/2); j = j+1)
			cc[j] = {absB[2*j+1], absB[2*j], absB[2*j-1]};
			
		for (j=0; j < (32/2); j = j+1) 
		begin	
			case(cc[j])
				3'b001 : pp[j] = {absA[32-1], absA}; 
				3'b010 : pp[j] = {absA[32-1], absA};
				3'b011 : pp[j] = {absA, 1'b0};
				3'b100 : pp[j] = {inv_a[32-1:0], 1'b0};
				3'b101 : pp[j] = inv_a; 
				3'b110 : pp[j] = inv_a;
				default : pp[j] = 0;
			endcase
			spp[j] = $signed(pp[j]);
			
			for (i=0 ; i<j ; i = i + 1)
				spp[j] = {spp[j], 2'b00};
		end
	
		product = spp[0];
	
		for (j=1; j < (32/2); j = j+1) begin
			product = product + spp[j];
		end
		//if(a[31] == 1'b1 || b[31] == 1'b1) begin
			//product = -product;
	   //end 
	end
	assign z = product;	
endmodule