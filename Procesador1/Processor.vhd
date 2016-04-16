
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Procesador1: no soporta inmediantos.
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
signal crs1_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');			
signal crs2_aux: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');		
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
	   reset : IN std_logic;
		cont : IN std_logic_vector(31 downto 0);          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
	   reset : IN std_logic;
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
		constante => "00000000000000000000000000000001",
		data => out_nPC,
		data_out => data_in
	);
	
	Inst_IM: IM PORT MAP(
	   reset => reset,
		cont => pc_out,
		instruction => im_out
	);
	
	Inst_RF: RF PORT MAP(
	   reset => reset,
		rs1 => im_out(18 downto 14),
		rs2 => im_out(4 downto 0),
		rd => im_out(29 downto 25),
		dwr => alu_out,
		crs1 => crs1_aux,
		crs2 => crs2_aux
	);
	
	Inst_ALU: ALU PORT MAP(
		A => crs1_aux,
		B => crs2_aux,
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

