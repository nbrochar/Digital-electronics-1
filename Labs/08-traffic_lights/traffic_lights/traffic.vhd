library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity traffic is
    port (clk: in STD_LOGIC;
            clr: in STD_LOGIC;
            lights: out STD_LOGIC_VECTOR(5 downto 0));
end traffic;

architecture traffic of traffic is
    type state_type is (G_R, Y_R, R_R1, R_G, R_Y, R_R2);
     signal state: state_type;

    --signal count: std_logic_vector(3 downto 0);
    --constant SEC5: std_logic_vector(3 downto 0) := "1111";
    --constant SEC1: std_logic_vector(3 downto 0) := "0011";
    signal count : unsigned(3 downto 0);
    constant SEC5: unsigned(3 downto 0) := "1111";
    constant SEC1: unsigned(3 downto 0) := "0011";

    begin
     Case_manager : process(clk, clr)
     begin
        if clr = '0' then
				if rising_edge(clk) then
					state <= G_R;
					count <= X"1";
				end if;

        --elsif clk'event and clk = '1' then
        elsif rising_edge(clk) then
        case state is
				when G_R =>
                    if count < SEC5 then
                        --state <= s0;
                        count <= count +1;
                    else
                        state <= Y_R;
                        count <= X"1";
                    end if;
				when Y_R =>
                    if count < SEC1 then
                        --state <= s0;
                        count <= count +1;
                    else
                        state <= R_R1;
                        count <= X"1";
                    end if;
				when R_R1 =>
                    if count < SEC1 then
                        --state <= s0;
                        count <= count +1;
                    else
                        state <= R_G;
                        count <= X"1";
                    end if;
				when R_G =>
                    if count < SEC5 then
                        --state <= s0;
                        count <= count +1;
                    else
                        state <= R_Y;
                        count <= X"1";
                    end if;
				when R_Y =>
                    if count < SEC1 then
                        --state <= s0;
                        count <= count +1;
                    else
                        state <= R_R2;
                        count <= X"1";
                    end if;
				when R_R2 =>
                    if count < SEC1 then
                        --state <= s0;
                        count <= count +1;
                    else
                        state <= G_R;
                        count <= X"1";
                    end if;
				when others =>
							state <= G_R;
			end case;
		end if;
	end process;
	
	Light_manager : process(state)
   begin
		case state is
			when G_R => lights <= "100001";
			when Y_R => lights <= "100010";
			when R_R1 => lights <= "100100";
			when R_G => lights <= "001100";
			when R_Y => lights <= "010100";
			when R_R2 => lights <= "100100";
			when others => lights <= "100001";
		end case;
	end process;
                   
	
	

end traffic;
