library verilog;
use verilog.vl_types.all;
entity not_32_bit is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        nota            : out    vl_logic_vector(31 downto 0)
    );
end not_32_bit;
