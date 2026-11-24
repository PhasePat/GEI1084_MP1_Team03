----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2026 04:12:25 PM
-- Design Name: 
-- Module Name: extend - behavioral
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

entity extend is
  Port( 
        ImmSrc  : in std_logic_vector(1 downto 0);
        InStr   : in std_logic_vector(23 downto 0);
        
        ExtImm  : out std_logic_vector(31 downto 0)
        );
end extend;

architecture behavioral of extend is
begin
    process(all) begin
        case ImmSrc is
            when "00" =>
                ExtImm <= (23 downto 0 => '0') & InStr(7 downto 0);
            when "01" =>
                ExtImm <= (19 downto 0 => '0') & InStr(11 downto 0);
            when "10" =>
                ExtImm <= (5 downto 0 => Instr(23)) & InStr(23 downto 0) & "00"; 
            when others =>
                ExtImm <= (others => '0');
        end case;
    end process;
end behavioral;
