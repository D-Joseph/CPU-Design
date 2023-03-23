library verilog;
use verilog.vl_types.all;
entity selectencodelogic is
    port(
        instruction     : in     vl_logic_vector(31 downto 0);
        Gra             : in     vl_logic;
        Grb             : in     vl_logic;
        Grc             : in     vl_logic;
        Rin             : in     vl_logic;
        Rout            : in     vl_logic;
        BAout           : in     vl_logic;
        C_sign_extended : out    vl_logic_vector(31 downto 0);
        RegInSel        : out    vl_logic_vector(15 downto 0);
        RegOutSel       : out    vl_logic_vector(15 downto 0);
        opcode          : out    vl_logic_vector(4 downto 0)
    );
end selectencodelogic;
