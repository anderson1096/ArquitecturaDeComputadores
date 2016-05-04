
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY IM_tb IS
END IM_tb;
 
ARCHITECTURE behavior OF IM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IM
    PORT(
         cont : IN  std_logic_vector(31 downto 0);
         instruction : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal cont : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal instruction : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IM PORT MAP (
          cont => cont,
          instruction => instruction
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		reset <= '1';
		
		wait for 30 ns;
		
		reset <= '0';
		cont <= "00000000000000000000000000000000";
		
		wait for 30 ns;
		
		cont <= "00000000000000000000000000000001";
		
		wait for 30 ns;
		
		cont <= "00000000000000000000000000000010";
		
		wait for 30 ns;
		
		cont <= "00000000000000000000000000000011";
		
		wait for 30 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
