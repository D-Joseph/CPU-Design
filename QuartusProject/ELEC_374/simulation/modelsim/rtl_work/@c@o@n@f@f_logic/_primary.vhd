library verilog;
use verilog.vl_types.all;
entity CONFF_logic is
    port(
        C2bits          : in     vl_logic_vector(1 downto 0);
        \bus\           : in     vl_logic_vector(31 downto 0);
        CONin           : in     vl_logic;
        CONout          : out    vl_logic
    );
end CONFF_logic;
