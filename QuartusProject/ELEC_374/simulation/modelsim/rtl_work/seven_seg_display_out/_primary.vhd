library verilog;
use verilog.vl_types.all;
entity seven_seg_display_out is
    port(
        outputt         : out    vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        data            : in     vl_logic_vector(3 downto 0)
    );
end seven_seg_display_out;
