
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Processor is
    Port ( reset : in  STD_LOGIC;
           constante : in  STD_LOGIC_VECTOR (31 downto 0);
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
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0); 
		dwr : IN std_logic_vector(31 downto 0); 		
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		ALUOP : IN std_logic_vector(5 downto 0);          
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
		constante => constante,
		data => out_nPC,
		data_out => data_in
	);
	
	Inst_IM: IM PORT MAP(
		cont => pc_out,
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
		rs1 => im_out(18 downto 14),
		rs2 => im_out(4 downto 0),
		rd => im_out(29 downto 25),
		dwr => alu_out,
		crs1 => crs1_aux,
		crs2 => crs2_aux
	);
	
	Inst_ALU: ALU PORT MAP(
		A => crs1_aux,
		B => mux_out,
		ALUOP => cpu_out,
		Salida => alu_out
	);
	
	Inst_CPU: CPU PORT MAP(
		op => im_out(31 downto 30),
		op3 => im_out(24 downto 19),
		salida => cpu_out
	);
	
data_out <= alu_out;

end Behavioral;

