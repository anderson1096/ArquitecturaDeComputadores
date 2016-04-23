
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY Processor_tb IS
END Processor_tb;
 
ARCHITECTURE behavior OF Processor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Processor
    PORT(
         reset : IN  std_logic;
         data_out : OUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          reset => reset,
          data_out => data_out,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
      reset<='1';
		
		wait for 100 ns;
		
		reset<='0';

      wait;
   end process;

END;
