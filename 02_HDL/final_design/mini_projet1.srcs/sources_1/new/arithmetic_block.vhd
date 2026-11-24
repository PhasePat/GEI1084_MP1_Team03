----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/27/2026 05:34:21 PM
-- Design Name: 
-- Module Name: arithmetic_block - behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity arithmetic_block is
    Port (
            operation_selector  : in  std_logic;
            
            A, 
            B                   : in  std_logic_vector(31 downto 0);
            
            cout                : out std_logic;
            result              : out std_logic_vector(31 downto 0)
            );
end arithmetic_block;

architecture behavioral of arithmetic_block is
begin

    process(all)
        variable temp_result : unsigned(32 downto 0);
    begin
        if operation_selector = '1' then
            temp_result := ('0' & unsigned(A)) + ('0' & not unsigned(B)) + 1;
        else
            temp_result := ('0' & unsigned(A)) + ('0' & unsigned(B));
        end if;
            result <= std_logic_vector(temp_result(31 downto 0));
            cout   <= temp_result(32);
    end process;

end Behavioral;
