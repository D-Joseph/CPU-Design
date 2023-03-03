module multiplication_32_bit(input wire signed [31:0] a, b, output wire signed[32*2-1:0] z);
	reg signed [2:0] combBits[15:0];
	reg signed [32:0] partialProduct[15:0];
	reg signed [63:0] shiftedPartialP[15:0];
	reg signed [63:0] product;
	
	integer j,i;
	
	wire [32:0] inv_a;
	assign inv_a = -a;
	
	always @ (a or b or inv_a) 
	begin
		combBits[0] = {b[1], b[0], 1'b0};
		
		for (j=1; j <= 15; j = j+1)
			combBits[j] = {b[2*j+1], b[2*j], b[2*j-1]};
			
		for (j=0; j <= 15; j = j+1) 
		begin	
			case(combBits[j])
				3'b001 : partialProduct[j] = {a[31], a}; 
				3'b010 : partialProduct[j] = {a[31], a};
				3'b011 : partialProduct[j] = {a, 1'b0};
				3'b100 : partialProduct[j] = {inv_a[31:0], 1'b0};
				3'b101 : partialProduct[j] = inv_a; 
				3'b110 : partialProduct[j] = inv_a;
				default : partialProduct[j] = 0;
			endcase
			shiftedPartialP[j] = $signed(partialProduct[j]);
			
			for (i=0 ; i<j ; i = i + 1)
				shiftedPartialP[j] = {shiftedPartialP[j], 2'b00};
		end
	
		product = shiftedPartialP[0];
	
		for (j=1; j <= 15; j = j+1) begin
			product = product + shiftedPartialP[j];
		end
	end
	assign z = product;	
endmodule


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
		//if(a[31] == 1'b1 || b[31] == 1'b1) begin
			//product = -product;
	   //end 