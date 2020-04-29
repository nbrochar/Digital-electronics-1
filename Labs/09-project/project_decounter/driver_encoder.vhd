----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:33:41 04/18/2020 
-- Design Name: 
-- Module Name:    driver_encoder - Behavioral 
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
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



-- this file manage the driving of the encoder and the countdown
entity driver_encoder is
	port(
		clk_i 				: in std_logic;
		pinA_i 				: in std_logic;
		pinB_i 				: in std_logic; 
		btn_encoder_i 		: in std_logic;
		decount_start_i 	: in std_logic;
		srst_n_i 			: in std_logic;   -- Synchronous reset (active low);
		ce_100Hz_i 			: in std_logic; 
		
		sec_h_o 			: out std_logic_vector(4-1 downto 0);
		sec_l_o 			: out std_logic_vector(4-1 downto 0);
		hth_h_o 			: out std_logic_vector(4-1 downto 0);
		hth_l_o 	        : out std_logic_vector(4-1 downto 0);
		digit_selected_o    : out std_logic_vector(2-1 downto 0)
	);
end driver_encoder;

architecture Behavioral of driver_encoder is
    type state_type is (sec_h, sec_l, hth_h, hth_l); -- state that describe the digit that will be modified by the encoder
    signal s_state: state_type;
	signal s_prev_pinA : std_logic := '0';
	signal s_cnt0 : unsigned(4-1 downto 0) := (others => '0');
	signal s_cnt1 : unsigned(4-1 downto 0) := (others => '0');
	signal s_cnt2 : unsigned(4-1 downto 0) := (others => '0');
	signal s_cnt3 : unsigned(4-1 downto 0) := (others => '0');
	signal s_cnt_btn : unsigned(2-1 downto 0) := (others => '0'); -- signal counter used to change the digit selected with the button
    signal s_countdown_progress : std_logic := '0';    -- signal used by the system to know the countdown is in progress (active high) 

begin

    -- Process to set the value and starting/processing the countdown --
    Digits_manager : process(clk_i)
    begin
        if rising_edge(clk_i) then
            if srst_n_i = '0' then
                s_cnt0 <= (others => '0');    -- reset to 0 all the digits  
                s_cnt1 <= (others => '0');
                s_cnt2 <= (others => '0');
                s_cnt3 <= (others => '0');
                s_countdown_progress <= '0';  -- reset the countdown progress signal
                
            elsif s_countdown_progress = '1' then    
                if ce_100Hz_i = '1' then        -- update every 10 ms
                    if (s_cnt3 = 0 and s_cnt2 = 0 and s_cnt1 = 0 and s_cnt0 = 0) then 
                        s_cnt3 <= "0000";
                        s_cnt2 <= "0000";
                        s_cnt1 <= "0000";
                        s_cnt0 <= "0000";
                        s_countdown_progress <= '0';    -- reset the countdown progress signal
                    
                    elsif (s_cnt2 = 0 and s_cnt1 = 0 and s_cnt0 = 0) then 
                        s_cnt2 <= "1001";
                        s_cnt1 <= "1001";
                        s_cnt0 <= "1001";
                        s_cnt3 <= s_cnt3 - 1;
                    
                    elsif (s_cnt1 = 0 and s_cnt0 = 0) then 
                        s_cnt1 <= "1001";
                        s_cnt0 <= "1001";
                        s_cnt2 <= s_cnt2 - 1;

                    elsif s_cnt0 = 0 then 
                        s_cnt0 <= "1001";
                        s_cnt1 <= s_cnt1 - 1;           
                    else 
                        s_cnt0 <= s_cnt0 - 1;   -- Normal operation
                    end if;    										
                end if;		
            
            elsif pinA_i /= s_prev_pinA then  -- output A of encoder is changing so the encoder is moving 
                case s_state is
                    when sec_h =>
                        if (pinB_i /= pinA_i) then          -- pinA /= pinB so its rotating clockwise
                            if s_cnt3 < 9 then
                                s_cnt3 <= s_cnt3 + 1;
                            else
                                s_cnt3 <= (others => '0');
                            end if;
                        else								-- pinA = pinB so its rotating counter clockwise
                            if s_cnt3 > 0 then
                                s_cnt3 <= s_cnt3 - 1;
                            else
                                s_cnt3 <= "1001";
                            end if;	                     
                        end if;
                
                    when sec_l =>
                        if (pinB_i /= pinA_i) then          -- pinA /= pinB so its rotating clockwise
                            if s_cnt2 < 9 then
                                s_cnt2 <= s_cnt2 +  1;
                            else
                                s_cnt3 <= (others => '0');
                            end if;
                        else						        -- pinA = pinB so its rotating counter clockwise
                            if s_cnt2 > 0 then
                                s_cnt2 <= s_cnt2 - 1;
                            else
                                s_cnt2 <= "1001";
                            end if;	                     
                        end if;
                
                    when hth_h =>
                        if (pinB_i /= pinA_i) then          -- pinA /= pinB so its rotating clockwise
                            if s_cnt1 < 9 then
                                s_cnt1 <= s_cnt1 + 1;
                            else
                                s_cnt1 <= (others => '0');
                            end if;
                        else							    -- pinA = pinB so its rotating counter clockwise
                            if s_cnt1 > 0 then
                                s_cnt1 <= s_cnt1 - 1;
                            else
                                s_cnt1 <= "1001";
                            end if;	                     
                        end if;
                
                    when hth_l =>
                        if (pinB_i /= pinA_i) then          -- pinA /= pinB so its rotating clockwise
                            if s_cnt0 < 9 then
                                s_cnt0 <= s_cnt0 + 1;
                            else
                                s_cnt0 <= (others => '0');
                            end if;
                        else							    -- pinA = pinB so its rotating counter clockwise
                            if s_cnt0 > 0 then
                                s_cnt0 <= s_cnt0 - 1;
                            else
                                s_cnt0 <= "1001";
                            end if;	                     
                        end if;
            
                    when others =>
                end case;
            end if;  
            if decount_start_i = '0' then       -- if the user is pressing the button to start the countdown (active low)
                s_countdown_progress <= '1';
            end if;
           
        s_prev_pinA <= pinA_i;  -- save the previous value of pinA to compare with the current one at the next rising edge of clk
        end if;
    end process;
	
    -- Process changing the state that correspond to the selected digit when the encoder button is pressed --
	State_manager : process(clk_i)
    begin
		if rising_edge(clk_i) then
			if srst_n_i = '0' then
				s_cnt_btn <= (others => '0');   -- the reset is setting the selected digit to the hundredths
			elsif (btn_encoder_i = '0') then 	-- btn_encoder_i = '0' means btn is pressed
				s_cnt_btn <= s_cnt_btn + 1;		-- pressing the encoder button increase the counter to change the digit selected
			end if; 
           
			case s_cnt_btn is
				when "00" =>
					s_state <= hth_l;
				when "01" =>
					s_state <= hth_h;
				when "10" =>
					s_state <= sec_l;
				when others =>
					s_state <= sec_h;
				end case;
		end if;
	end process;

    -- update of the outputs according to the signals --
    sec_h_o <= std_logic_vector(s_cnt3);
    sec_l_o <= std_logic_vector(s_cnt2);
    hth_h_o <= std_logic_vector(s_cnt1);
    hth_l_o <= std_logic_vector(s_cnt0);
    digit_selected_o <= (std_logic_vector(s_cnt_btn));

end Behavioral;

