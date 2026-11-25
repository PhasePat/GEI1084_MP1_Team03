----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2026 05:16:21 PM
-- Design Name: 
-- Module Name: flopenr - behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flopenr is
    generic (width : integer := 2);
    Port(
            clk,         
            reset,
            en      : in std_logic;
            
            d       : in std_logic_vector(width-1 downto 0);
            
            q       : out std_logic_vector(width-1 downto 0)
            );
end flopenr;

architecture behavioral of flopenr is
    signal reg : std_logic_vector(width-1 downto 0) := (others => '0');
begin
    process(clk, reset) begin

        if Reset then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if en then
                reg <= d;
            end if;
        end if;
    end process;
    q <= reg;
end behavioral;
