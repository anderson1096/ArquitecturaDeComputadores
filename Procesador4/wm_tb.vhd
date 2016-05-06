LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY wm_tb IS
END wm_tb;
 
ARCHITECTURE behavior OF wm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WindowsManager
    PORT(
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         cwp : IN  std_logic;
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         nrs1 : OUT  std_logic_vector(5 downto 0);
         nrs2 : OUT  std_logic_vector(5 downto 0);
         nrd : OUT  std_logic_vector(5 downto 0);
         ncwp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');
   signal cwp : std_logic := '0';
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal nrs1 : std_logic_vector(5 downto 0);
   signal nrs2 : std_logic_vector(5 downto 0);
   signal nrd : std_logic_vector(5 downto 0);
   signal ncwp : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WindowsManager PORT MAP (
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          cwp => cwp,
          op => op,
          op3 => op3,
          nrs1 => nrs1,
          nrs2 => nrs2,
          nrd => nrd,
          ncwp => ncwp
        );


 

   -- Stimulus process
   stim_proc: process
   begin		

		rs1 <= "10000";
		rs2 <= "10001";
		rd <= "10010";
		cwp <= '0';
		op <= "10";
		op3 <="000000";
		
		wait for 20 ns;
		
		cwp <= '1';
		
		wait for 20 ns;
		
		rs1 <= "11000";
		rs2 <= "11001";
		rd <= "11010";
		
		wait for 20 ns;
		
		cwp <= '0';
		
		wait for 20 ns;
		
		rs1 <= "00000";
		rs2 <= "00001";
		rd <= "00010";
		
		wait for 20 ns;
		
		cwp <= '1';

      wait;
   end process;

END;
