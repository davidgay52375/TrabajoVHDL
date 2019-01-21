library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity semaforocruce2_tb is
--  Port ( );
end semaforocruce2_tb;

architecture Behavioral of semaforocruce2_tb is
    component semaforocruce2 is
        port (
            clk, reset, button: in std_logic;
            red1, yellow1, green1, red2, yellow2, green2: out std_logic
        );
    end component;
    
    signal clk: std_logic := '0';
    signal reset, button, red1, yellow1, green1, red2, yellow2, green2: std_logic;

begin
    inst_semaforocruce2: semaforocruce2 port map (
        clk => clk,
        reset => reset,
        button => button,
        red1 => red1,
        yellow1 => yellow1,
        green1 => green1,
        red2 => red2,
        yellow2 => yellow2,
        green2 => green2
    );
    
    clk <= not clk after 100 ns;
    reset <= '1' after 0 ns, '0' after 100 ns;
    
    process
    begin
        button <= '1';
        wait for 20000 ms;
        
    end process;

end Behavioral;
