library verilog;
use verilog.vl_types.all;
entity rotate_right_32_bit is
    port(
        \in\            : in     vl_logic_vector(31 downto 0);
        numRotateBits   : in     vl_logic_vector(4 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0)
    );
end rotate_right_32_bit;
