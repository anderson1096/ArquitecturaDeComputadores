
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY MUX_tb IS
END MUX_tb;
 
ARCHITECTURE behavior OF MUX_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         b : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal salida : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          a => a,
          b => b,
          sel => sel,
          salida => salida
        );

   -- Stimulus process
   stim_proc: process
   begin		
      
		a <= "00101011001010110010101100101011";
		b <= "11101011001010110010101100100000";
		sel <= '0';
		
		wait for 30 ns;
		
		sel <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
