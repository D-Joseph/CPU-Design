library verilog;
use verilog.vl_types.all;
entity CPUDesignProject is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        stop            : in     vl_logic;
        inport_data_in  : in     vl_logic_vector(31 downto 0);
        outport_data_out: out    vl_logic_vector(31 downto 0);
        bus_contents    : out    vl_logic_vector(31 downto 0);
        operation       : out    vl_logic_vector(4 downto 0);
        Run             : out    vl_logic
    );
end CPUDesignProject;
