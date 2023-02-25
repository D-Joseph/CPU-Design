module multiplication_32_bit (
  input wire signed [31:0] a,
  input wire signed [31:0] b,
  output wire[63:0] z
);


integer i,j;
reg [2:0] groupedBits[15:0];
reg  [32:0] partialProduct[15:0];
reg  [63:0] shiftedPartialProduct[15:0];
reg  [63:0] product;
reg [31:0] absA, absB;

always@(a or b) begin
if(a[31] == 1'b1) begin
	absA = -a;
	end
else if(b[31] == 1'b1) begin
	absB = -b;
	end
 else begin
	absA = a;
	absB = b;
end 
end

wire [32:0] neg_a;
assign neg_a = -absA; // 2s Complement of a

always @(a or b or neg_a) begin
  groupedBits[0] = {absB[1], absB[0], 1'b0};
  
  for(i=1; i <= 15; i = i + 1) begin
    groupedBits[i] = {absB[2*i+1], absB[2*i], absB[2*i-1]};
  end
  
  for(i = 0; i <= 15; i = i + 1) begin
	  case(groupedBits[i])
		 3'b001 : partialProduct[i] = {absA[31], absA}; 
		 3'b010 : partialProduct[i] = {absA[31], absA};
		 3'b101 : partialProduct[i] = neg_a;
		 3'b110 : partialProduct[i] = neg_a;
		 3'b011 : partialProduct[i] = {neg_a << 1};
		 3'b100 : partialProduct[i] = {neg_a << 1};
		 default : partialProduct[i] = 0;
	  endcase
     //shiftedPartialProduct[i] = $signed(partialProduct[i]);
	  for (i=0 ; i<j ; i = i + 1)
				spp[j] = {spp[j], 2'b00};
  end
	  
	  product = shiftedPartialProduct[0];
	  
	  for(j = 0; j <= 15; j = j + 1) begin
			product = product + shiftedPartialProduct[j];
	  end
	  if(a[31] == 1'b1 || b[31] == 1'b1) begin
		product = -product;
	  end 
end

assign z = product;

endmodule

module multiplication_32_bit (
  input wire signed [31:0] a,
  input wire signed [31:0] b,
  output wire[63:0] z
);


integer i,j;
reg [2:0] groupedBits[15:0];
reg  [32:0] partialProduct[15:0];
reg  [63:0] shiftedPartialProduct[15:0];
reg  [63:0] product;
reg [31:0] absA, absB;

always@(a or b) begin
if(a[31] == 1'b1) begin
	absA = -a;
	end
else if(b[31] == 1'b1) begin
	absB = -b;
	end
 else begin
	absA = a;
	absB = b;
end 
end

wire [32:0] neg_a;
assign neg_a = -absA; // 2s Complement of a

always @(a or b or neg_a) begin
  groupedBits[0] = {absB[1], absB[0], 1'b0};
  
  for(i=1; i <= 15; i = i + 1) begin
    groupedBits[i] = {absB[2*i+1], absB[2*i], absB[2*i-1]};
  end
  
  for(i = 0; i <= 15; i = i + 1) begin
	  case(groupedBits[i])
		 3'b001 : partialProduct[i] = {absA[31], absA}; 
		 3'b010 : partialProduct[i] = {absA[31], absA};
		 3'b101 : partialProduct[i] = neg_a;
		 3'b110 : partialProduct[i] = neg_a;
		 3'b011 : partialProduct[i] = {neg_a << 1};
		 3'b100 : partialProduct[i] = {neg_a << 1};
		 default : partialProduct[i] = 0;
	  endcase
     //shiftedPartialProduct[i] = $signed(partialProduct[i]);
	  for (j=0 ; j<i ; j = j + 1)
				shiftedPartialProduct[j] = {shiftedPartialProduct[j], 2'b00};
  end
	  
	  product = shiftedPartialProduct[0];
	  
	  for(j = 0; j <= 15; j = j + 1) begin
			product = product + shiftedPartialProduct[j];
	  end
	  if(a[31] == 1'b1 || b[31] == 1'b1) begin
		product = -product;
	  end 
end

assign z = product;

endmodule