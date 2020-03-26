--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:07:34 03/26/2020
-- Design Name:   
-- Module Name:   /home/nico/Documents/VUT/Digital-electronics-1/Labs/08-traffic_lights/traffic_lights/tb_top.vhd
-- Project Name:  traffic_lights
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
 
ENTITY tb_top IS
END tb_top;
 
ARCHITECTURE behavior OF tb_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         clk_i : IN  std_logic;
         BTN0 : IN  std_logic;
         LD0_CPLD : OUT  std_logic;
         LD1_CPLD : OUT  std_logic;
         LD2_CPLD : OUT  std_logic;
         LD4_CPLD : OUT  std_logic;
         LD5_CPLD : OUT  std_logic;
         LD6_CPLD : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal BTN0 : std_logic := '0';

 	--Outputs
   signal LD0_CPLD : std_logic;
   signal LD1_CPLD : std_logic;
   signal LD2_CPLD : std_logic;
   signal LD4_CPLD : std_logic;
   signal LD5_CPLD : std_logic;
   signal LD6_CPLD : std_logic;

   -- Clock period definitions
   constant clk_i_period : time := 100 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i => clk_i,
          BTN0 => BTN0,
          LD0_CPLD => LD0_CPLD,
          LD1_CPLD => LD1_CPLD,
          LD2_CPLD => LD2_CPLD,
          LD4_CPLD => LD4_CPLD,
          LD5_CPLD => LD5_CPLD,
          LD6_CPLD => LD6_CPLD
        );

   -- Clock process definitions
   clk_i_process :process
   begin
		clk_i <= '0';
		wait for clk_i_period/2;
		clk_i <= '1';
		wait for clk_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_i_period*10;

      -- insert stimulus here 
		BTN0 <= '1';

      wait;
   end process;

END;
