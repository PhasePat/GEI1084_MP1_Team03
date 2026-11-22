----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2026 04:10:33 PM
-- Design Name: 
-- Module Name: flags_registers - structural
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

entity flags_registers is
  Port(
        clk,         
        reset,
        CondEx          : in std_logic;
        
        FlagW           : in std_logic_vector(1 downto 0);
        
        ALUFlags        : in std_logic_vector(3 downto 0);
        
        Flag_N_Z,
        Flag_C_V        : out std_logic_vector(1 downto 0)
        );
end flags_registers;

architecture structural of flags_registers is
    Signal FlagWrite  : std_logic_vector(1 downto 0);
begin
    FlagWrite <= FlagW and (CondEx & CondEx);
    
    nz : entity work.flopenr generic map (2)
    port map(
                clk     => clk, 
                reset   => reset, 
                en      => FlagWrite(1), 
                d       => ALUFlags(3 downto 2), 
                q       => Flag_N_Z
                );
    
  cv : entity work.flopenr generic map (2)
    port map(
                clk     => clk,
                reset   => reset, 
                en      => FlagWrite(0), 
                d       => ALUFlags(1 downto 0), 
                q       => Flag_C_V
                );
                
end structural;
