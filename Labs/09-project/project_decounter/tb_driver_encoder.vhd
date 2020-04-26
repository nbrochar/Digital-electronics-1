--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:01:31 04/19/2020
-- Design Name:   
-- Module Name:   /home/nico/Documents/VUT/Digital-electronics-1/Labs/09-project/project_decounter/tb_driver_encoder.vhd
-- Project Name:  project_decounter
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: driver_encoder
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
 
ENTITY tb_driver_encoder IS
END tb_driver_encoder;
 
ARCHITECTURE behavior OF tb_driver_encoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT driver_encoder
    PORT(
         clk_i : IN  std_logic;
         pinA_i : IN  std_logic;
         pinB_i : IN  std_logic;
         btn_encoder_i : IN  std_logic;
         decount_start_i : IN  std_logic;
         srst_n_i : IN  std_logic;
         ce_100Hz_i : IN  std_logic;
         sec_h_o : OUT  std_logic_vector(3 downto 0);
         sec_l_o : OUT  std_logic_vector(3 downto 0);
         hth_h_o : OUT  std_logic_vector(3 downto 0);
         hth_l_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal pinA_i : std_logic := '0';
   signal pinB_i : std_logic := '0';
   signal btn_encoder_i : std_logic := '0';
   signal decount_start_i : std_logic := '0';
   signal srst_n_i : std_logic := '0';
   signal ce_100Hz_i : std_logic := '0';

 	--Outputs
   signal sec_h_o : std_logic_vector(3 downto 0);
   signal sec_l_o : std_logic_vector(3 downto 0);
   signal hth_h_o : std_logic_vector(3 downto 0);
   signal hth_l_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 100 us;
	constant ce_100Hz_i_period : time := 10 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: driver_encoder PORT MAP (
          clk_i => clk_i,
          pinA_i => pinA_i,
          pinB_i => pinB_i,
          btn_encoder_i => btn_encoder_i,
          decount_start_i => decount_start_i,
          srst_n_i => srst_n_i,
          ce_100Hz_i => ce_100Hz_i,
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
		srst_n_i <= '1';
		btn_encoder_i <= '1';
		decount_start_i <= '1';
		
		LOOP_1: FOR i IN 0 TO 6 LOOP 
			pinA_i <= '0';
			wait for 5 ms;
			pinB_i <= '0';
			wait for 5 ms;
			pinA_i <= '1';
			wait for 5 ms;
			pinB_i <= '1';
			wait for 5 ms;
		END LOOP LOOP_1;
		
		btn_encoder_i <= '0';
		wait for 101 us;
		btn_encoder_i <= '1';
		
		LOOP_2: FOR i IN 0 TO 3 LOOP 
			pinA_i <= '0';
			wait for 5 ms;
			pinB_i <= '0';
			wait for 5 ms;
			pinA_i <= '1';
			wait for 5 ms;
			pinB_i <= '1';
			wait for 5 ms;
		END LOOP LOOP_2;
		
		btn_encoder_i <= '0';
		wait for 101 us;
		btn_encoder_i <= '1';
		
		LOOP_3: FOR i IN 0 TO 4 LOOP 
			pinA_i <= '0';
			wait for 5 ms;
			pinB_i <= '0';
			wait for 5 ms;
			pinA_i <= '1';
			wait for 5 ms;
			pinB_i <= '1';
			wait for 5 ms;
		END LOOP LOOP_3;
		
		btn_encoder_i <= '0';
		wait for 101 us;
		btn_encoder_i <= '1';
		
		LOOP_4: FOR i IN 0 TO 2 LOOP 
			pinA_i <= '0';
			wait for 5 ms;
			pinB_i <= '0';
			wait for 5 ms;
			pinA_i <= '1';
			wait for 5 ms;
			pinB_i <= '1';
			wait for 5 ms;
		END LOOP LOOP_4;
		
		decount_start_i <= '0';
		

      wait;
   end process;

END;
