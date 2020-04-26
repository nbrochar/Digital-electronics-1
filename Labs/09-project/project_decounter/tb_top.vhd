--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:11:35 04/19/2020
-- Design Name:   
-- Module Name:   /home/nico/Documents/VUT/Digital-electronics-1/Labs/09-project/project_decounter/tb_top.vhd
-- Project Name:  project_decounter
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
         BTN1 : IN  std_logic;
         PinSwitch_Encoder : IN  std_logic;
         PinA_Encoder : IN  std_logic;
         PinB_Encoder : IN  std_logic;
         LED0 : OUT std_logic;	
         LED1 : OUT std_logic;
         LED2 : OUT std_logic;
         LED3 : OUT std_logic;
         disp_dp_o : OUT  std_logic;
         disp_seg_o : OUT  std_logic_vector(6 downto 0);
         disp_dig_o : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_i : std_logic := '0';
   signal BTN0 : std_logic := '1';
   signal BTN1 : std_logic := '1';
   signal PinSwitch_Encoder : std_logic := '1';
   signal PinA_Encoder : std_logic := '0';
   signal PinB_Encoder : std_logic := '0';

 	--Outputs
   signal LED0 : std_logic;	
   signal LED1 : std_logic;
   signal LED2 : std_logic;
   signal LED3 : std_logic;
   signal disp_dp_o : std_logic;
   signal disp_seg_o : std_logic_vector(6 downto 0);
   signal disp_dig_o : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_i_period : time := 100 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          clk_i => clk_i,
          BTN0 => BTN0,
          BTN1 => BTN1,
          PinSwitch_Encoder => PinSwitch_Encoder,
          PinA_Encoder => PinA_Encoder,
          PinB_Encoder => PinB_Encoder,
          LED0 => LED0,
          LED1 => LED1,
          LED2 => LED2,
          LED3 => LED3,
          disp_dp_o => disp_dp_o,
          disp_seg_o => disp_seg_o,
          disp_dig_o => disp_dig_o
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
		--BTN0 <= '1';
		--PinSwitch_Encoder <= '1';
		--BTN1 <= '1';
        
		-- turning the knob clockwise --
		LOOP_1: FOR i IN 0 TO 4 LOOP 
			PinA_Encoder <= '0';
			wait for 5 ms;
			PinB_Encoder <= '0';
			wait for 5 ms;
			PinA_Encoder <= '1';
			wait for 5 ms;
			PinB_Encoder <= '1';
			wait for 5 ms;
		END LOOP LOOP_1;
        ---------------------------------
        
        -- turning the knob counter clockwise --
        LOOP_2: FOR i IN 0 TO 3 LOOP 
			PinB_Encoder <= '0';
			wait for 5 ms;
			PinA_Encoder <= '0';
			wait for 5 ms;
			PinB_Encoder <= '1';
			wait for 5 ms;
			PinA_Encoder <= '1';
			wait for 5 ms;
		END LOOP LOOP_2;
        ----------------------------------------
        
		-- simulation of the encoder button pressed, the digit selected is changed --
		PinSwitch_Encoder <= '0';   
		wait for 101 us;
		PinSwitch_Encoder <= '1';
        -----------------------------------------------------------------------------
		
        -- turning the knob clockwise --
		LOOP_3: FOR i IN 0 TO 3 LOOP 
			PinA_Encoder <= '0';
			wait for 5 ms;
			PinB_Encoder <= '0';
			wait for 5 ms;
			PinA_Encoder <= '1';
			wait for 5 ms;
			PinB_Encoder <= '1';
			wait for 5 ms;
		END LOOP LOOP_3;
        ---------------------------------
        
		-- simulation of the encoder button pressed, the digit selected is changed
		PinSwitch_Encoder <= '0';   
		wait for 101 us;
		PinSwitch_Encoder <= '1';
        -----------------------------------------------------------------------------
		
        -- turning the knob clockwise --
		LOOP_4: FOR i IN 0 TO 1 LOOP 
			PinA_Encoder <= '0';
			wait for 5 ms;
			PinB_Encoder <= '0';
			wait for 5 ms;
			PinA_Encoder <= '1';
			wait for 5 ms;
			PinB_Encoder <= '1';
			wait for 5 ms;
		END LOOP LOOP_4;
        ---------------------------------
        
		-- simulation of the encoder button pressed, the digit selected is changed
		PinSwitch_Encoder <= '0';   
		wait for 101 us;
		PinSwitch_Encoder <= '1';
        -----------------------------------------------------------------------------
		
         -- turning the knob clockwise --
		LOOP_5: FOR i IN 0 TO 2 LOOP 
			PinA_Encoder <= '0';
			wait for 5 ms;
			PinB_Encoder <= '0';
			wait for 5 ms;
			PinA_Encoder <= '1';
			wait for 5 ms;
			PinB_Encoder <= '1';
			wait for 5 ms;
		END LOOP LOOP_5;
        ---------------------------------
		
        -- pressing the countdown start button --
		BTN1 <= '0'; 
        wait for 50 ms;     -- time during which the button is pressed
        BTN1 <= '1';    
        -----------------------------------------
        
        wait for 300 ms;
        -- turning the knob clockwise --
        -- to verify that's not possible to modify the digits by turning the knob during the countdown
		LOOP_6: FOR i IN 0 TO 4 LOOP 
			PinA_Encoder <= '0';
			wait for 5 ms;
			PinB_Encoder <= '0';
			wait for 5 ms;
			PinA_Encoder <= '1';
			wait for 5 ms;
			PinB_Encoder <= '1';
			wait for 5 ms;
		END LOOP LOOP_6;
        ---------------------------------
        
        wait for 10000 ms;
        -- pressing the reset button --
		BTN0 <= '0'; 
        wait for 50 ms;     -- time during which the button is pressed
        BTN0 <= '1';    
        -----------------------------------------
        
      wait;
   end process;

END;
