library verilog;
use verilog.vl_types.all;
entity mux_2_to_1 is
    port(
        mux_in_1        : in     vl_logic_vector(31 downto 0);
        mux_in_2        : in     vl_logic_vector(31 downto 0);
        \select\        : in     vl_logic;
        mux_out         : out    vl_logic_vector(31 downto 0)
    );
end mux_2_to_1;
