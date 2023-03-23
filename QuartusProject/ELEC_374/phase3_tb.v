`timescale 1ns/10ps

module phase3_tb;
	reg clk, rst, stop;
	wire [31:0] inport_data_in, outport_data_out, bus_contents;
	wire [4:0] operation;

CPUDesignProject DUT(
	.clk(clk),
	.rst(rst),
	.stop(stop),
	.inport_data_in(inport_data_in), 
	.outport_data_out(outport_data_out),
	.bus_contents(bus_contents),
	.operation(operation)
);

initial
	begin
		clk = 0;
		rst = 0;
end

always
		#10 clk <= ~clk;

endmodule
