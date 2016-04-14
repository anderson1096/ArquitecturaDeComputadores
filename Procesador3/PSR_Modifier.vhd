library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PSR_Modifier is
    Port ( ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_Result : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end PSR_Modifier;

architecture Behavioral of PSR_Modifier is

begin

	process(ALUOP, ALU_Result, Crs1, Crs2)
	begin
		--Algo
	end process;
	
end Behavioral;

