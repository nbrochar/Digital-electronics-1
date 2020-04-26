library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decounter is
port(
		clk_i : in std_logic;
		srst_n_i : in  std_logic; 
		ce_100Hz_i : in  std_logic; 
		cnt_en_i : in  std_logic; 

		sec_h_o : out std_logic_vector(4-1 downto 0);
		sec_l_o : out std_logic_vector(4-1 downto 0);
		hth_h_o : out std_logic_vector(4-1 downto 0);
		hth_l_o : out std_logic_vector(4-1 downto 0)
	);
end entity decounter;

architecture Behavioral of decounter is
    signal s_cnt0 : unsigned(4-1 downto 0) := "1001";
	 signal s_cnt1 : unsigned(4-1 downto 0) := "1001";
	 signal s_cnt2 : unsigned(4-1 downto 0) := "1001";
	 signal s_cnt3 : unsigned(4-1 downto 0) := "1001";
 
begin
	 cnt : process (clk_i)
    begin
        if rising_edge(clk_i) then  -- Rising clock edge
            if srst_n_i = '0' then  -- Synchronous reset (active low)
                s_cnt0 <= "1001";  -- Clear all bits
					 s_cnt1 <= "1001";  -- Clear all bits
					 s_cnt2 <= "1001";  -- Clear all bits
					 s_cnt3 <= "1001";  -- Clear all bits
            elsif cnt_en_i = '1' then
					if ce_100Hz_i = '1' then 
								
						if s_cnt0 = 0 then 
							s_cnt0 <= "1001";
							if s_cnt1 > 0 then
								s_cnt1 <= s_cnt1 - 1;
							else
								s_cnt1 <= "1001";
							end if;
						else 
							s_cnt0 <= s_cnt0 - 1; -- Normal operation
						end if;
						
						if (s_cnt1 = 0 and s_cnt0 = 0) then 
							s_cnt1 <= "1001";
							if s_cnt2 > 0 then
								s_cnt2 <= s_cnt2 - 1;
							else
								s_cnt2 <= "1001";
							end if;
						end if;		
						
						if (s_cnt2 = 0 and s_cnt1 = 0 and s_cnt0 = 0) then 
							s_cnt2 <= "1001";
							if s_cnt3 > 0 then
								s_cnt3 <= s_cnt3 - 1;
							else
								s_cnt3 <= "1001";
							end if;
						end if;
						
						if (s_cnt3 = 0 and s_cnt2 = 0 and s_cnt1 = 0 and s_cnt0 = 0) then 
							s_cnt3 <= "0000";
							s_cnt2 <= "0000";
							s_cnt1 <= "0000";
							s_cnt0 <= "0000";
						end if;
									
								
						
						
									
					
					end if;		
				end if;
        end if;
    end process cnt;
	 

	 sec_h_o <= std_logic_vector(s_cnt3);
	 sec_l_o <= std_logic_vector(s_cnt2);
	 hth_h_o <= std_logic_vector(s_cnt1);
    hth_l_o <= std_logic_vector(s_cnt0);
end architecture Behavioral;