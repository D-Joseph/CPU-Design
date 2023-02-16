library verilog;
use verilog.vl_types.all;
entity encoder_32_to_5 is
    port(
        encoderInput    : in     vl_logic_vector(31 downto 0);
        encoderOutput   : out    vl_logic_vector(4 downto 0)
    );
end encoder_32_to_5;
