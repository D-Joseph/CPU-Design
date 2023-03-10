library verilog;
use verilog.vl_types.all;
entity encoder_2_to_4 is
    port(
        decoderInput    : in     vl_logic_vector(1 downto 0);
        decoderOutput   : out    vl_logic_vector(3 downto 0)
    );
end encoder_2_to_4;
