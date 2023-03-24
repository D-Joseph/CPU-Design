library verilog;
use verilog.vl_types.all;
entity ram is
    port(
        data_in         : in     vl_logic_vector(31 downto 0);
        address         : in     vl_logic_vector(8 downto 0);
        clk             : in     vl_logic;
        writeEnable     : in     vl_logic;
        data_out        : out    vl_logic_vector(31 downto 0)
    );
end ram;
