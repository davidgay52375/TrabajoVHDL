library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity semaforo_cruce is
    Port (
        button, clk, reset: in std_logic;
        red, green, yellow, enable: out std_logic
     );
end semaforo_cruce;

architecture Behavioral of semaforo_cruce is
type STATES is (S0_1, S1_1, S2_1, S3_1);
signal current_state, next_state: STATES;
signal reloj, inicio: std_logic;
signal count: std_logic_vector(4 downto 0);
signal count2: std_logic_vector(24 downto 0);
begin

    process (clk)
    begin
        if clk'event and clk ='1' then
            current_state <= next_state;
            count2 <= count2 + 1;
            if count2 = 25000000 then
                count2 <= (others => '0');
                reloj <= not reloj;
            end if;
        end if;
    end process;
    
    process (reloj, inicio)
    begin
        if reloj'event and reloj = '1' then
            if inicio = '1' then
                count <= count - 1;
                if count = 0 then
                    count <= "10100";
                end if;
            end if;
        end if;
    end process;
    
    process(current_state, button)
    begin
        next_state <= current_state;
        case current_state is
            when S0_1 => inicio <= '0';
                red <= '0';
                yellow <= '0';
                green <= '1';
                if button = '1' then
                    next_state <= S1_1;
                else
                    next_state <= S0_1;
                end if;
            when S1_1 => inicio <= '1';
                red <= '0';
                if count = 20 then
                    yellow <= '1';
                elsif count = 19 then
                    yellow <= '0';
                elsif count = 18 then
                    yellow <= '1';
                elsif count = 17 then
                    yellow <= '0';
                elsif count = 16 then
                    yellow <= '1';
                elsif count = 14 then
                    next_state <= S2_1;
                end if;
            when S2_1 => inicio <= '1';
                red <= '1';
                yellow <= '0';
                if count = 4 then
                    next_state <= S3_1;
                else
                    next_state <= S2_1;
                end if;
            when S3_1 => inicio <= '1';
                enable <= '1';
                if count = 0 then
                    next_state <= S0_1;
                else
                    next_state <= S3_1;
                end if;
        end case;                                
    end process;
end Behavioral;