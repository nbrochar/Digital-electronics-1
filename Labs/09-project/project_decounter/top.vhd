----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:44:39 03/20/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    port (
        clk_i    				: in std_logic;
        BTN0  					: in std_logic;   -- Synchronous reset
        BTN1 				    : in std_logic;   -- start decount
        PinSwitch_Encoder       : in std_logic;   -- change digit
        PinA_Encoder 			: in std_logic; 			
        PinB_Encoder 			: in std_logic; 
         
        LED0  					: out std_logic;	-- LEDS to show the selected digit
        LED1  					: out std_logic;
        LED2  					: out std_logic;
        LED3  					: out std_logic;
        disp_dp_o     		    : out std_logic;  -- Decimal point
        disp_seg_o    		    : out std_logic_vector(7-1 downto 0);
        disp_dig_o    		    : out std_logic_vector(4-1 downto 0)
    );
end top;

architecture Behavioral of top is

    signal s_data0, s_data1, s_data2, s_data3 : std_logic_vector(4-1 downto 0);
	signal s_ce_100Hz_i  : std_logic;
	signal s_digit_selected : std_logic_vector(2-1 downto 0);

begin

	--------------------------------------------------------------------
    -- Sub-block of driver_7seg entity
    --- WRITE YOUR CODE HERE
	SEGENTITY : entity work.driver_7seg
        port map(
            clk_i => clk_i,  
            srst_n_i => BTN0,
            data0_i => s_data0,   
            data1_i => s_data1,
            data2_i => s_data2, 
            data3_i => s_data3,
            dp_i => "1011",   

            dp_o => disp_dp_o,                        
            seg_o => disp_seg_o,   
            dig_o => disp_dig_o   
        );

	--------------------------------------------------------------------
    -- Sub-block of clock_enable entity. 
    --- WRITE YOUR CODE HERE
	CLOCK_ENABLE : entity work.clock_enable
        generic map(
            g_NPERIOD => x"0064" -- 10 ms for ce_100Hz_i
        )
        port map (
            clk_i => clk_i,
            srst_n_i => BTN0,			
            clock_enable_o => s_ce_100Hz_i
        );
        
	--------------------------------------------------------------------
    -- Sub-block of stopwatch entity. 
    --- WRITE YOUR CODE HERE
	DRIVER_ENCODER : entity work.driver_encoder
        port map (
            clk_i => clk_i,
            pinA_i => PinA_Encoder,
            pinB_i => PinB_Encoder,
            btn_encoder_i => PinSwitch_Encoder,  
            decount_start_i => BTN1,
            srst_n_i => BTN0,
            ce_100Hz_i => s_ce_100Hz_i,
            
            sec_h_o => s_data3,
            sec_l_o => s_data2,
            hth_h_o => s_data1,
            hth_l_o => s_data0,
            digit_selected_o => s_digit_selected
        );
			
	Digit_selection_process : process(s_digit_selected)
	begin
        case s_digit_selected is
            when "00" =>
                LED0 <= '0';
                LED1 <= '1';
                LED2 <= '1';
                LED3 <= '1';
            when "01" =>
                LED0 <= '1';
                LED1 <= '0';
                LED2 <= '1';
                LED3 <= '1';
            when "10" =>
                LED0 <= '1';
                LED1 <= '1';
                LED2 <= '0';
                LED3 <= '1';
            when others =>
                LED0 <= '1';
                LED1 <= '1';
                LED2 <= '1';
                LED3 <= '0';
        end case;
	end process;		
    
end Behavioral;

