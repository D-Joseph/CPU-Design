library verilog;
use verilog.vl_types.all;
entity IncPC_32_bit is
    generic(
        qInitial        : integer := 0
    );
    port(
        clk             : in     vl_logic;
        IncPC           : in     vl_logic;
        enable          : in     vl_logic;
        inputPC         : in     vl_logic_vector(31 downto 0);
        newPC           : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of qInitial : constant is 1;
end IncPC_32_bit;
