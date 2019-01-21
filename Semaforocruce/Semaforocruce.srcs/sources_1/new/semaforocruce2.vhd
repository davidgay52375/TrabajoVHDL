library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity semaforocruce2 is
    Port (
        clk, reset, button: in std_logic;
        red1, green1, yellow1, red2, green2, yellow2: out std_logic
     );
end semaforocruce2;

architecture Behavioral of semaforocruce2 is
type STATES is (S0, S1, S2, S3);
signal current_state, next_state: STATES;
signal reloj: std_logic;
signal count: integer range 0 to 20;
begin

    counter: process (clk, reset, button)
    begin
        if reset = '1' then
            current_state <= S0;
            count <= 0;
        elsif rising_edge(clk) then
            current_state <= next_state;
            if button = '1' then
                count <= count -1;
            end if;
            if count = 0 then
                count <= 20;
            end if;
        end if;
    end process;
    mxstate_dec:process(current_state, button, count)
    begin
        case current_state is
            when S0 =>
                red1 <= '0';
                red2 <= '1';
                yellow1 <= '0';
                yellow2 <= '0';
                green1 <= '1';
                green2 <= '0';
                if button = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                red1 <= '0';
                red2 <= '1';
                yellow2 <= '0';
                green1 <= '0';
                green2 <= '0';
                if count = 20 then
                    yellow1 <= '1';
                elsif count = 19 then
                    yellow1 <= '0';
                elsif count = 18 then
                    yellow1 <= '1';
                elsif count = 17 then
                    yellow1 <= '0';
                elsif count = 16 then
                    yellow1 <= '1';
                elsif count = 14 then
                    next_state <= S2;
                end if;
            when S2 =>
                red1 <= '1';
                red2 <='0';
                yellow1 <= '0';
                yellow2 <= '0';
                green1 <= '0';
                green2 <= '1';
                if count = 4 then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 =>
                red1 <= '1';
                red2 <='0';
                yellow1 <= '0';
                green1 <= '0';
                green2 <= '0';
                if count = 3 then
                    yellow2 <= '1';
                elsif count = 2 then
                    yellow2 <= '0';
                elsif count = 1 then
                    yellow2 <= '1';
                elsif count = 0 then
                    next_state <= S0;
                end if;
            end case;
    end process;
end Behavioral;
