
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY CPU_tb IS
END CPU_tb;
 
ARCHITECTURE behavior OF CPU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         salida : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal salida : std_logic_vector(5 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          op => op,
          op3 => op3,
          salida => salida
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		op <= "00";
		op3 <= "000000"; --add
      wait for 30 ns;	

		op <= "10";
		op3 <= "000000"; --add
      wait for 30 ns;

		op3 <= "000001"; --and
		
      wait for 30 ns;	
		
		op3 <= "000011"; --and
		
      wait for 30 ns;
		
		op <= "00";
		op3 <= "000011"; --and
		
      wait for 30 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
