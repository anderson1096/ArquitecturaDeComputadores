
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Adder_tb IS
END Adder_tb;
 
ARCHITECTURE behavior OF Adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder
    PORT(
         constante : IN  std_logic_vector(31 downto 0);
         data : IN  std_logic_vector(31 downto 0);
         data_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal constante : std_logic_vector(31 downto 0) := (others => '0');
   signal data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder PORT MAP (
          constante => constante,
          data => data,
          data_out => data_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      constante <= "00000000000000000000000000000100";
		data<="00000000000000000000000000000100";
		
		wait for 20 ns;
		
		data<= "00000000000000000000000000000101";
		
		wait for 20 ns;
		
		data<= "00000000000000000000000000000111";
		
		

      wait;
   end process;

END;
