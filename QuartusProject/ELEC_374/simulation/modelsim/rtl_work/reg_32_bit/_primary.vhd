library verilog;
use verilog.vl_types.all;
entity reg_32_bit is
    port(
        clk             : in     vl_logic;
        clr             : in     vl_logic;
        enable          : in     vl_logic;
        d               : in     vl_logic_vector(31 downto 0);
        q               : out    vl_logic_vector(31 downto 0)
    );
end reg_32_bit;
