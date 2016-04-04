
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin


end Behavioral;

