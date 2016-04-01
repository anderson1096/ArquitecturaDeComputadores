
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor is
    Port ( reset : in  STD_LOGIC;
           constante : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC);
end Processor;

architecture Behavioral of Processor is

signal out_nPC: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal data_in: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');

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
		data_out => data_out
	);
	
		Inst_Adder: Adder PORT MAP(
		constante => constante,
		data => out_nPC,
		data_out => data_in
	);

end Behavioral;

