
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Procesador3 :
-- Monociclo, soporta la generación de integer conditional codes

entity Processor is
    Port ( reset : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end Processor;

architecture Behavioral of Processor is

signal out_nPC: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal data_in: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal pc_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal im_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal seu_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal imm13_aux: STD_LOGIC_VECTOR(12 downto 0):=(others=>'0');--en formato3 
																--el inmmediato va del bit 0 al 12
																
signal crs1_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');			
signal crs2_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');		
signal mux_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');			
signal cpu_out: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');
signal alu_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');	
signal psr_modifier_out: STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');	
signal psr_out: STD_LOGIC := '0';	

signal nrs1_out_wm: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');						
signal nrs2_out_wm: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');		
signal nrd_out_wm: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0');	

signal ncwp_out_wm: STD_LOGIC:='0';	
signal cwp_out_psr: STD_LOGIC:='0';

COMPONENT nPC
	PORT(
		reset : IN std_logic;
		clk : IN std_logic;
		data : IN std_logic_vector(31 downto 0);          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT Adder
	PORT(
		constante : IN std_logic_vector(31 downto 0);
		data : IN std_logic_vector(31 downto 0);          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT IM
	PORT(
		cont : IN std_logic_vector(31 downto 0);     
		reset : in  STD_LOGIC;
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MUX
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0); 
		dwr : IN std_logic_vector(31 downto 0); 	
		reset : in  STD_LOGIC;
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);      
		Carry : IN std_logic ;  
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT CPU
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		salida : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
		COMPONENT PSR_Modifier
	PORT(
		ALUOP : IN std_logic_vector(5 downto 0);
		ALU_Result : IN std_logic_vector(31 downto 0);
		Crs1 : IN std_logic_vector(31 downto 0);
		Crs2 : IN std_logic_vector(31 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0);
		reset : in  STD_LOGIC
		);
	END COMPONENT;

	COMPONENT PSR
	PORT(
		nzvc : IN std_logic_vector(3 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;   
		ncwp : IN std_logic;
		carry : OUT std_logic;
		cwp : out std_logic
		);
	END COMPONENT;
	
	COMPONENT WindowsManager
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		cwp : IN std_logic;
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0);
		ncwp : OUT std_logic
		);
	END COMPONENT;

begin

	Inst_nPC: nPC PORT MAP(
		reset => reset,
		clk => clk,
		data => data_in,
		data_out => out_nPC
	);
	
	Inst_PC: nPC PORT MAP(
		reset => reset,
		clk => clk,
		data => out_nPC,
		data_out => pc_out
	);
	
		Inst_Adder: Adder PORT MAP(
		constante => "00000000000000000000000000000001",
		data => out_nPC,
		data_out => data_in
	);
	
	Inst_IM: IM PORT MAP(
		cont => pc_out,
		reset => reset,
		instruction => im_out
	);
	
	Inst_SEU: SEU PORT MAP(
		imm13 => im_out(12 downto 0),
		imm32 => seu_out
	);
	
	Inst_MUX: MUX PORT MAP(
		a => crs2_aux,
		b => seu_out,
		sel => im_out(13),
		salida => mux_out
	);
	
	Inst_RF: RF PORT MAP(
		rs1 => nrs1_out_wm,
		rs2 => nrs2_out_wm,
		rd => nrd_out_wm,
		dwr => alu_out,
		reset => reset,
		crs1 => crs1_aux,
		crs2 => crs2_aux
	);
	
	Inst_ALU: ALU PORT MAP(
		A => crs1_aux,
		B => mux_out,
		ALUOP => cpu_out,
		Carry => psr_out,
		Salida => alu_out
	);
	
	Inst_CPU: CPU PORT MAP(
		op => im_out(31 downto 30),
		op3 => im_out(24 downto 19),
		salida => cpu_out
	);
	
	Inst_PSR_Modifier: PSR_Modifier PORT MAP(
		ALUOP => cpu_out,
		ALU_Result => alu_out,
		Crs1 => crs1_aux,
		Crs2 => mux_out,
		nzvc => psr_modifier_out,
		reset => reset
	);
	
	Inst_PSR: PSR PORT MAP(
		nzvc => psr_modifier_out,
		reset => reset,
		clk => clk,
		ncwp => ncwp_out_wm,
		carry => psr_out,
		cwp => cwp_out_psr
	);
	
	Inst_WindowsManager: WindowsManager PORT MAP(
		rs1 => im_out(18 downto 14),
		rs2 => im_out(4 downto 0),
		rd => im_out(29 downto 25),
		cwp => cwp_out_psr,
		op => im_out(31 downto 30),
		op3 => im_out(24 downto 19),
		nrs1 => nrs1_out_wm,
		nrs2 => nrs2_out_wm,
		nrd => nrd_out_wm,
		ncwp => ncwp_out_wm
	);
	
data_out <= alu_out;

end Behavioral;

