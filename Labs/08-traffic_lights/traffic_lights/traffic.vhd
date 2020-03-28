library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity traffic is
    port (clk_i: in STD_LOGIC;
			 ce_3Hz_i : STD_LOGIC; -- signal clock enable 3Hz
          srst_n_i: in STD_LOGIC;
          lights_o: out STD_LOGIC_VECTOR(5 downto 0));
end traffic;

architecture traffic of traffic is
    type state_type is (G_R, Y_R, R_R1, R_G, R_Y, R_R2);
    signal s_state: state_type;
	 signal s_count : unsigned(3 downto 0);
    --signal count: std_logic_vector(3 downto 0);
    --constant SEC5: std_logic_vector(3 downto 0) := "1111";
    --constant SEC1: std_logic_vector(3 downto 0) := "0011";
    constant SEC5: unsigned(3 downto 0) := "1111";
    constant SEC1: unsigned(3 downto 0) := "0011";

    begin
     Case_manager : process(clk_i, srst_n_i, ce_3Hz_i)
     begin
        if srst_n_i = '0' then
				if rising_edge(clk_i) then
					s_state <= G_R;
					s_count <= X"1";
				end if;

        --elsif clk'event and clk = '1' then
        elsif rising_edge(ce_3Hz_i) then
        case s_state is
				when G_R =>
                    if s_count < SEC5 then
                        --state <= s0;
                        s_count <= s_count +1;
                    else
                        s_state <= Y_R;
                        s_count <= X"1"; -- reset at 1 so counting until 15 makes 15 periods 
                    end if;
				when Y_R =>
                    if s_count < SEC1 then
                        --state <= s0;
                        s_count <= s_count +1;
                    else
                        s_state <= R_R1;
                        s_count <= X"1"; -- reset at 1 so counting until 3 makes 3 periods 
                    end if;
				when R_R1 =>
                    if s_count < SEC1 then
                        --state <= s0;
                        s_count <= s_count +1;
                    else
                        s_state <= R_G;
                        s_count <= X"1";
                    end if;
				when R_G =>
                    if s_count < SEC5 then
                        --state <= s0;
                        s_count <= s_count +1;
                    else
                        s_state <= R_Y;
                        s_count <= X"1";
                    end if;
				when R_Y =>
                    if s_count < SEC1 then
                        --state <= s0;
                        s_count <= s_count +1;
                    else
                        s_state <= R_R2;
                        s_count <= X"1";
                    end if;
				when R_R2 =>
                    if s_count < SEC1 then
                        --state <= s0;
                        s_count <= s_count +1;
                    else
                        s_state <= G_R;
                        s_count <= X"1";
                    end if;
				when others =>
							s_state <= G_R;
			end case;
		end if;
	end process;
	
	Light_manager : process(s_state)
   begin
		case s_state is
			when G_R => lights_o <= "100001";
			when Y_R => lights_o <= "100010";
			when R_R1 => lights_o <= "100100";
			when R_G => lights_o <= "001100";
			when R_Y => lights_o <= "010100";
			when R_R2 => lights_o <= "100100";
			when others => lights_o <= "100001";
		end case;
	end process;
                  
end traffic;
