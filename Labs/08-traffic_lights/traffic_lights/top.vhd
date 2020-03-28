----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:19:16 03/26/2020 
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
	 clk_i    : in  std_logic;
    BTN0  : in std_logic;       -- Synchronous reset
	 LD0_CPLD, LD1_CPLD, LD2_CPLD :  out std_logic; -- North/South lights
	 LD4_CPLD, LD5_CPLD, LD6_CPLD :  out std_logic -- East/West lights
	 );
end top;

architecture Behavioral of top is
	 signal s_NS_lights, s_EW_lights : std_logic_vector(3-1 downto 0);
	 signal s_3Hz_clock : std_logic;
begin
	 LD6_CPLD <= s_NS_lights(2);
	 LD5_CPLD <= s_NS_lights(1);
	 LD4_CPLD <= s_NS_lights(0);
	 LD2_CPLD <= s_EW_lights(2);
	 LD1_CPLD <= s_EW_lights(1);
	 LD0_CPLD <= s_EW_lights(0);
	 
	 
	 CLOCK_ENABLE : entity work.clock_enable
			generic map(
				g_NPERIOD => x"0D05" -- dividing 10kHz clock by 3333 to obtain a 3 Hz clock 
			)
			-- we choose a frequency of 3Hz because counting until 3 makes 3 periods of 1/3s so 1 second
			-- and counting until 15 makes 15 periods of 1/3s so 5 seconds
			port map (
				clk_i => clk_i,
				srst_n_i => BTN0,			
				clock_enable_o => s_3Hz_clock
			);
			
	 TRAFFIC : entity work.traffic
			port map(
				clk_i => clk_i,
				ce_3Hz_i => s_3Hz_clock,
            srst_n_i  => BTN0,	
            lights_o(5 downto 3) => s_NS_lights,
				lights_o(2 downto 0) => s_EW_lights
			);
end Behavioral;

