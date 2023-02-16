library verilog;
use verilog.vl_types.all;
entity CPUDesignProject is
    port(
        PCout           : in     vl_logic;
        ZLowout         : in     vl_logic;
        MDRout          : in     vl_logic;
        R2out           : in     vl_logic;
        R3out           : in     vl_logic;
        MARin           : in     vl_logic;
        ZLowIn          : in     vl_logic;
        PCin            : in     vl_logic;
        MDRin           : in     vl_logic;
        IRin            : in     vl_logic;
        Yin             : in     vl_logic;
        IncPC           : in     vl_logic;
        Read            : in     vl_logic;
        operation       : in     vl_logic_vector(4 downto 0);
        R1in            : in     vl_logic;
        R2in            : in     vl_logic;
        R3in            : in     vl_logic;
        clk             : in     vl_logic;
        MDatain         : in     vl_logic_vector(31 downto 0);
        ZLow_data_out   : out    vl_logic_vector(31 downto 0)
    );
end CPUDesignProject;
