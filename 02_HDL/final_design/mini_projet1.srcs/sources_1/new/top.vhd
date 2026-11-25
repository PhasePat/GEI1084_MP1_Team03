----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 07:08:37 PM
-- Design Name: 
-- Module Name: top - structural
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

entity top is
  generic (InstructionFile : string := "Instructions.txt");
  Port( 
        clk,
        reset         : in std_logic;
        
        ALUResult,
        WriteData     : out std_logic_vector(31 downto 0)
        );
end top;

architecture structural of top is
    
    signal PCSrc,
           MemToReg,
           MemW,
           ALUSrc,
           Link,
           RegW             : std_logic;
    
    signal ALUControl,
           ImmSrc,
           RegSrc,
           FlagW            : std_logic_vector(1 downto 0);
            
    signal ALUFlags         : std_logic_vector(3 downto 0);
    
    signal Instr            : std_logic_vector(31 downto 0);
begin

    datapath : entity work.datapath
    generic map (InstructionFile => InstructionFile)
    port map(
                clk             => clk,
                reset           => reset,
                Link            => Link,
                PCSrc           => PCSrc,
                MemToReg        => MemToReg,
                MemWrite        => MemW,
                ALUSrc          => ALUSrc,
                RegWrite        => RegW,  
                ALUControl      => ALUControl,
                ImmSrc          => ImmSrc,
                RegSrc          => RegSrc,      
                ALUFlags        => ALUFlags,
                Instr           => Instr,
                ALUResult_out   => ALUResult,
                WriteData_out   => WriteData
                );
                              
                
    control_unit : entity work.control_unit
    port map(   
                clk         => clk,
                reset       => reset,
                Cond        => Instr(31 downto 28),
                Op          => Instr(27 downto 26),
                Funct       => Instr(25 downto 20),
                Rd          => Instr(15 downto 12),
                ALUFlags    => ALUFlags,
                PCSrc       => PCSrc,
                RegWrite    => RegW,
                MemWrite    => MemW,
                MemToReg    => MemToReg,
                ALUSrc      => ALUSrc,
                ImmSrc      => ImmSrc,
                RegSrc      => RegSrc,
                ALUControl  => ALUControl,
                Link        => Link
                );

end structural;
