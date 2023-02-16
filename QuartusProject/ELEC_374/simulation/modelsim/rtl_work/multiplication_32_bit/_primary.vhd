library verilog;
use verilog.vl_types.all;
entity multiplication_32_bit is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(63 downto 0)
    );
end multiplication_32_bit;
