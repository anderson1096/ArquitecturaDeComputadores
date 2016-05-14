
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY CPU_TB IS
END CPU_TB;
 
ARCHITECTURE behavior OF CPU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         icc : IN  std_logic_vector(3 downto 0);
         cond : IN  std_logic_vector(3 downto 0);
         salida : OUT  std_logic_vector(5 downto 0);
         wrenmem : OUT  std_logic;
         rfsource : OUT  std_logic_vector(1 downto 0);
         rfdest : OUT  std_logic;
         pcsource : OUT  std_logic_vector(1 downto 0);
         we : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal icc : std_logic_vector(3 downto 0) := (others => '0');
   signal cond : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal salida : std_logic_vector(5 downto 0);
   signal wrenmem : std_logic;
   signal rfsource : std_logic_vector(1 downto 0);
   signal rfdest : std_logic;
   signal pcsource : std_logic_vector(1 downto 0);
   signal we : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          op => op,
          op3 => op3,
          icc => icc,
          cond => cond,
          salida => salida,
          wrenmem => wrenmem,
          rfsource => rfsource,
          rfdest => rfdest,
          pcsource => pcsource,
          we => we
        );


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		op <= "10";
		op3 <= "000010";
		icc <= "0000";
		cond <= "1111"; --error

      -- insert stimulus here 

      wait;
   end process;

END;
