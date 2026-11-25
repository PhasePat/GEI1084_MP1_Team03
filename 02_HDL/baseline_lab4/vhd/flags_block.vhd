----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/27/2026 05:47:10 PM
-- Design Name: 
-- Module Name: flags_block - behavioral
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

entity flags_block is
    Port (
            sum31, 
            cout        : in std_logic;
            
            ALUControl  : in std_logic_vector(1 downto 0);
            
            A, 
            B, 
            result      : in std_logic_vector(31 downto 0);
            
            flags       : out std_logic_vector(3 downto 0)
            );
end flags_block;

architecture behavioral of flags_block is
begin

    process(all)
        variable    overflow, 
                    carry, 
                    negative, 
                    zero : std_logic;
    begin
        overflow    := not (A(31) xor B(31) xor ALUControl(0)) and (A(31) xor sum31) and not ALUControl(1); 
        carry       := not ALUControl(1) and cout;
        negative    := result(31);
        zero        := nor result;
        
        flags(3) <= negative;
        flags(2) <= zero;
        flags(1) <= carry;
        flags(0) <= overflow;
    end process;


end behavioral;
