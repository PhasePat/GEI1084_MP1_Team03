----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/27/2026 05:32:00 PM
-- Design Name: 
-- Module Name: ALU - structural
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

entity ALU is
    generic(N : integer := 4; M : integer := 32);
    Port (  
            A,
            B           : in std_logic_vector(M-1 downto 0);
            
            ALUControl  : in std_logic_vector(1 downto 0);
            
            ALUFlags    : out std_logic_vector(N-1 downto 0);
            result      : out std_logic_vector(M-1 downto 0)
            );
end ALU;

architecture structural of ALU is
   Signal cout                  : std_logic;
    signal flags                : std_logic_vector(N-1 downto 0);
    
    signal  arithmetic_result, 
            logic_result, 
            internal_result     : std_logic_vector(M-1 downto 0);
begin
    
    arithmetic_unit : entity work.arithmetic_block
    port map (
                A                   => A,
                B                   => B,
                operation_selector  => ALUControl(0),
                cout                => cout,
                result              => arithmetic_result
                );
    
    logic_unit : entity work.logic_block
    port map (
                A                   => A,
                B                   => B,
                operation_selector  => ALUControl(0),
                result              => logic_result
                );
    
    flags_unit : entity work.flags_block
    port map (
                A           => A,
                B           => B,
                ALUControl  => ALUControl,
                cout        => cout,
                sum31       => arithmetic_result(31),
                result      => internal_result,
                flags       => flags
                );
    
    process(all) begin
        if ALUControl(1) = '1' then
            internal_result <= logic_result;
        else
            internal_result <= arithmetic_result;
        end if;
    end process ;
    
    result      <= internal_result;
    ALUFlags    <= flags;
    
end structural;
