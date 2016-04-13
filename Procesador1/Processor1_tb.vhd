
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY Processor1_tb IS
END Processor1_tb;
 
ARCHITECTURE behavior OF Processor1_tb IS 
 
 
    COMPONENT Processor
    PORT(
         reset : IN  std_logic;
         constante : IN  std_logic_vector(31 downto 0);
         data_out : OUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal constante : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Processor PORT MAP (
          reset => reset,
          constante => constante,
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
		constante<="00000000000000000000000000000001";
		
		wait for 20 ns;
		
		reset<='0';
--		constante<="00000000000000000000000000000000";
      wait;
   end process;

END;
