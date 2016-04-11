
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--ALU soporta las siguientes operaciones

-- ADD : 000000
-- SUB : 000001
-- AND : 000010
-- ANDN (op1 and not op2) : 000011
-- OR : 000100
-- ORN : 000101
-- XOR : 000110
-- XNOR : 000111

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

process(ALUOP)
	begin
		case ALUOP is
		
			when 	"000000" => 
				Salida <= A + B;
										
			when 	"000001" => 
				Salida <= A - B;
				
			when 	"000010" => 
				Salida <= A and B;
										
			when 	"000011" => 
				Salida <= A and not B;
			
			when 	"000100" => 
				Salida <= A or B;
										
			when 	"000101" => 
				Salida <= A or not B;
			
			when 	"000110" => 
				Salida <= A xor B;
										
			when 	"000111" => 
				Salida <= A xnor B;
			
			when others =>
				Salida <= (others=>'1'); --error
			
			end case;

	end process;	

end Behavioral;

