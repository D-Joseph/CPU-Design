library verilog;
use verilog.vl_types.all;
entity division_32_bit is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        c               : out    vl_logic_vector(63 downto 0)
    );
end division_32_bit;
