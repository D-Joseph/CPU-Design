library verilog;
use verilog.vl_types.all;
entity mux_32_to_1 is
    port(
        BusMuxIn_R0     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R1     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R2     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R3     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R4     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R5     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R6     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R7     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R8     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R9     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R10    : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R11    : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R12    : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R13    : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R14    : in     vl_logic_vector(31 downto 0);
        BusMuxIn_R15    : in     vl_logic_vector(31 downto 0);
        BusMuxIn_HI     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_LO     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_Z_HI   : in     vl_logic_vector(31 downto 0);
        BusMuxIn_Z_LO   : in     vl_logic_vector(31 downto 0);
        BusMuxIn_PC     : in     vl_logic_vector(31 downto 0);
        BusMuxIn_MDR    : in     vl_logic_vector(31 downto 0);
        BusMuxIn_In_Port: in     vl_logic_vector(31 downto 0);
        C_Sign_Extended : in     vl_logic_vector(31 downto 0);
        BusMuxOut       : out    vl_logic_vector(31 downto 0);
        \select\        : in     vl_logic_vector(4 downto 0)
    );
end mux_32_to_1;
