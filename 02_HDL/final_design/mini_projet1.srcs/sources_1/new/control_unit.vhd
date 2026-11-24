----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2026 03:22:30 PM
-- Design Name: 
-- Module Name: control_unit - structural
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

entity control_unit is
  Port(
        clk,
        reset       : in std_logic;
        
        Op          : in std_logic_vector(1 downto 0);
        
        Cond,
        Rd,
        ALUFlags    : in std_logic_vector(3 downto 0);
        
        Funct       : in std_logic_vector(5 downto 0);
        
        Link,
        PCSrc,
        RegWrite,
        MemWrite,
        MemToReg,
        ALUSrc      : out std_logic;
        
        ImmSrc,
        RegSrc,
        ALUControl  : out std_logic_vector(1 downto 0)
        );
end control_unit;

architecture structural of control_unit is
    signal PCS,
           MemW,
           RegW     : std_logic;
    
    signal FlagW    : std_logic_vector(1 downto 0);
            
begin
    decoder : entity work.decoder
    port map(
                Op          => Op,        
                Cond        => Cond,
                Rd          => Rd,
                Funct       => Funct,
                PCS         => PCS,
                MemToReg    => MemToReg,
                MemW        => MemW,
                ALUSrc      => ALUSrc,
                RegW        => RegW,     
                ALUControl  => ALUControl,
                ImmSrc      => ImmSrc,
                RegSrc      => RegSrc,
                FlagW       => FlagW,
                Link        => Link
                );
                
    conditional_logic : entity work.conditional_logic
    port map(
                clk         => clk,
                reset       => reset,
                PCS         => PCS,
                RegW        => RegW,
                MemW        => MemW,
                FlagW       => FlagW,
                Cond        => Cond,
                ALUFlags    => ALUFlags,
                PCSrc       => PCSrc,
                RegWrite    => RegWrite,
                MemWrite    => MemWrite
                );

end structural;
