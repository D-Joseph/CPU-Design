library verilog;
use verilog.vl_types.all;
entity division_32_bit is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        z               : out    vl_logic_vector(63 downto 0)
    );
end division_32_bit;
