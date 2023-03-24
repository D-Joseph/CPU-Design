module clkDivider (
	input RAM_Clock,
	output reg slwClock
);

reg [3:0] counter;

initial 
	begin
			slwClock = 0;
			counter = 4'b0000;
	end

always@(posedge RAM_Clock)
begin
	counter = counter + 1;
	if(counter == 4)begin
		slwClock <= 1;
	end	
	else if (counter == 8)begin
		slwClock <= 0;
		counter <= 4'b0000;
	end	
end

endmodule