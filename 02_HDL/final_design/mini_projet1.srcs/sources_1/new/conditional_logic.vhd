----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2026 03:39:59 PM
-- Design Name: 
-- Module Name: conditional_logic - structural
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

entity conditional_logic is
  Port(
        clk,
        reset,
        PCS,
        RegW,
        MemW        : in std_logic;
        
        FlagW       : in std_logic_vector(1 downto 0);
        
        Cond,
        ALUFlags    : in std_logic_vector(3 downto 0);
        
        PCSrc,
        RegWrite,
        MemWrite    : out std_logic
        );
end conditional_logic;


architecture structural of conditional_logic is
    Signal  CondEx : std_logic;
    Signal  Flag_N_Z,
            Flag_C_V : std_logic_vector(1 downto 0);
begin
    flags_registers : entity work.flags_registers
    port map(   
                clk => clk,         
                reset => reset,
                CondEx => CondEx,
                FlagW => Flagw,
                ALUFlags => ALUFlags,
                Flag_N_Z => Flag_N_Z,
                Flag_C_V => Flag_C_V
                );
                
    condition_check : entity work.condition_check
    port map(   
                Flag_N_Z => Flag_N_Z,
                Flag_C_V => Flag_C_V,   
                Cond => Cond,            
                CondEx => CondEx
                );
    
    PCSrc       <= PCS and CondEx;
    RegWrite    <= RegW and CondEx;
    MemWrite    <= MemW and CondEx;

end structural;
