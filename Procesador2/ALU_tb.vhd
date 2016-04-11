
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         ALUOP : IN  std_logic_vector(5 downto 0);
         Salida : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal ALUOP : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal Salida : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          ALUOP => ALUOP,
          Salida => Salida
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		ALUOP <= "000000";--suma
      B <= "00000000000000000000000000000100";
		A <= "00000000000000000000000000000101";

		wait for 30 ns;
		
		ALUOP <= "111111";--caso inexistente
		
		wait for 30 ns;
		
		ALUOP <= "000001";--resta
		
		wait for 30 ns;
		
		ALUOP <= "000010";--and
		
		wait for 30 ns;
		
		ALUOP <= "000110";--xor
		
      -- insert stimulus here 

      wait;
   end process;

END;
