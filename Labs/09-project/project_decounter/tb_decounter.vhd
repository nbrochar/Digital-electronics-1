--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:01:22 04/19/2020
-- Design Name:   
-- Module Name:   /home/nico/Documents/VUT/Digital-electronics-1/Labs/09-project/project_decounter/tb_decounter.vhd
-- Project Name:  project_decounter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decounter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_decounter IS
END tb_decounter;
 
ARCHITECTURE behavior OF tb_decounter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decounter
    PORT(
         clk_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         ce_100Hz_i : IN  std_logic;
         cnt_en_i : IN  std_logic;
         sec_h_o : OUT  std_logic_vector(3 downto 0);
         sec_l_o : OUT  std_logic_vector(3 downto 0);
         hth_h_o : OUT  std_logic_vector(3 downto 0);
         hth_l_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal ce_100Hz_i : std_logic := '0';
   signal cnt_en_i : std_logic := '0';

 	--Outputs
   signal sec_h_o : std_logic_vector(3 downto 0);
   signal sec_l_o : std_logic_vector(3 downto 0);
   signal hth_h_o : std_logic_vector(3 downto 0);
   signal hth_l_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 10 ms;
	constant ce_100Hz_i_period : time := 10 ms;
	
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decounter PORT MAP (
          clk_i => clk_i,
          srst_n_i => srst_n_i,
          ce_100Hz_i => ce_100Hz_i,
          cnt_en_i => cnt_en_i,
          sec_h_o => sec_h_o,
          sec_l_o => sec_l_o,
          hth_h_o => hth_h_o,
          hth_l_o => hth_l_o
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 
	ce_100Hz_i_period_process :process
   begin
		ce_100Hz_i <= '0';
		wait for ce_100Hz_i_period/2;
		ce_100Hz_i <= '1';
		wait for ce_100Hz_i_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_i_period*10;

      -- insert stimulus here 
		cnt_en_i <= '1';
		srst_n_i <= '1';

      wait;
   end process;

END;
