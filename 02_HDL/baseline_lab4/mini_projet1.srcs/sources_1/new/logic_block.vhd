----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/27/2026 05:36:01 PM
-- Design Name: 
-- Module Name: logic_block - behavioral
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

entity logic_block is
    Port (
            operation_selector  : in  std_logic;
            
            A, 
            B                : in  std_logic_vector(31 downto 0);
            
            result              : out std_logic_vector(31 downto 0)
            );
end logic_block;

architecture behavioral of logic_block is
begin

    process(all)
    begin
        if operation_selector then
            result <= A or B;
        else
            result <= A and B;  
        end if;
    end process;
    
end behavioral;
