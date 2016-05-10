
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--SALIDAS PARA OP = 10
-- ADD : 000000
-- SUB : 000001
-- AND : 000010
-- ANDN (op1 and not op2) : 000011
-- OR : 000100
-- ORN : 000101
-- XOR : 000110
-- XNOR : 000111
-- SUBcc: 001000
-- SUBx : 001001
-- SUBxcc: 001010
-- ANDcc : 001011
-- ANDNcc : 001100
-- ORcc : 001101
-- ORNcc : 001110
-- XORcc : 001111
-- XNORcc : 010000
-- ADDx : 010001
-- ADDXcc : 010010
-- ADDcc : 010011



entity CPU is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0); --formato
           op3 : in  STD_LOGIC_VECTOR (5 downto 0); --operacion
           salida : out  STD_LOGIC_VECTOR (5 downto 0);
			  wrenmem : out STD_LOGIC;
			  rfsource: out STD_LOGIC_VECTOR(1 downto 0);
			  rfdest : out STD_LOGIC;
			  pcsource: out STD_LOGIC_VECTOR(1 downto 0);
			  we : out std_logic);
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
						
					when 	"010100" => --SUBcc
						Salida <= "001000";
					
					when 	"001100" => --SUBx
						Salida <= "001001";
					
					when 	"011100" => --SUBxcc
						Salida <= "001010";
					
					when 	"010001" => --ANDcc
						Salida <= "001011";
						
					when 	"010101" => --ANDNcc
						Salida <= "001100";	
						
					when 	"010010" => --ORcc
						Salida <= "001101";	
						
					when 	"010110" => --ORNcc
						Salida <= "001110";	
						
					when 	"010011" => --XORcc
						Salida <= "001111";
						
					when 	"010111" => --XNORcc
						Salida <= "010000";
						
					when 	"001000" => --ADDx
						Salida <= "010001";
					
					when 	"011000" => --ADDxcc
						Salida <= "010010";
						
					when 	"010000" => --ADDcc
						Salida <= "010011";

					
					when others =>
						Salida <= (others=>'1'); --error
					
					end case;
			else
				Salida <= (others=>'1'); --No existe
			end if;
			
			
		end process;	
	
	process(op, op3)
		begin
		
			if(op = "11") then --formato3 de load y store
			
				if (op3 = "000100") then --store
					wrenmem <= '1';
				else	--sino, es load
					wrenmem <= '0';
				end if;
			else
				wrenmem <= '0';
			end if;
	end process;
	
	process(op)
		begin
			if (op="10") then --aritmeticas
				rfsource <= "10";
			elsif (op="11") then --load
				rfsource <= "00";
			elsif (op="01") then --call
				rfsource <= "10";
				rfdest <= '1';
			else	
				rfdest <= '1';
			end if;
	end process;
	
	process(op) --proceso para el muxup
		begin
			if (op = "01")then --es un call
				pcsource <= "00";
			elsif (op = "00") then --es un branch
				pcsource <= "01";
			elsif (op = "10") then --es aritmetica
				pcsource <= "10";
			else
				pcsource <= "11"; --es la alu
			end if;
	end process;
			
	
	
			
end Behavioral;

