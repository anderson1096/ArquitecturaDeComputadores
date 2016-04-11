
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;


entity RF is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
			  dwr : in  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           crs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Behavioral of RF is

type reg is array (0 to 39) of std_logic_vector (31 downto 0);


signal myReg: reg; 

begin
process(rs1,rs2,rd,dwr)
	begin 
		if(rd/="00000")then
			Myreg(conv_integer(rd)) <= dwr; --arreglar
		end if;
		crs1 <= Myreg(conv_integer(rs1));
		crs2 <= Myreg(conv_integer(rs2));
	end process;
		
end Behavioral;

