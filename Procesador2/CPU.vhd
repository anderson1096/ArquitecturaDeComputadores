
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ADD : 000000
-- SUB : 000001
-- AND : 000010
-- ANDN (op1 and not op2) : 000011
-- OR : 000100
-- ORN : 000101
-- XOR : 000110
-- XNOR : 000111

entity CPU is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           salida : out  STD_LOGIC_VECTOR (5 downto 0));
end CPU;

architecture Behavioral of CPU is

begin
	
	process(op, op3)
		begin
		
			if(op = "10") then --formato3
			
				case op3 is
				
					when 	"000000" => --Add
						salida <= "000000";
												
					when 	"000100" => --Sub
						salida <= "000001";
						
					when "000001"	 => -- And
						salida <= "000010";
												
					when "000101"	 => --Andn
						Salida <= "000011";
					
					when "000010"	 => --or
						Salida <= "000100";
												
					when "000110"	 => --orn
						Salida <= "000101";
					
					when "000011"	 => --xor
						Salida <= "000110";
												
					when 	"000111" => --xnor
						Salida <= "000111";
					
					when others =>
						Salida <= (others=>'0'); --error
					
					end case;
			end if;
			
		end process;	
	
	

end Behavioral;

