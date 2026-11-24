----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 03:47:55 PM
-- Design Name: 
-- Module Name: decoder - structural
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

entity decoder is
  Port( 
        Op          : in std_logic_vector(1 downto 0);
        
        Cond,
        Rd          : in std_logic_vector(3 downto 0);
        
        Funct       : in std_logic_vector(5 downto 0);
        
        Link,
        PCS,
        MemToReg,
        MemW,
        ALUSrc,
        RegW    : out std_logic;
        
        ALUControl,
        ImmSrc,
        RegSrc,
        FlagW      : out std_logic_vector(1 downto 0)
        );
end decoder;

architecture structural of decoder is
    signal branch,
           s_regW,
           ALUOp,
           noWrite_s        : std_logic := '0';         
begin

    pc_logic : entity work.pc_logic
    port map(
                RegW    => s_regW and not noWrite_s,
                Branch  => branch,
                Rd      => Rd,
                PCS     => PCS
                );
                
    main_decoder : entity work.main_decoder
    port map(
                Funct5      => Funct(5),
                Funct4      => Funct(4),
                Funct0      => Funct(0),               
                Op          => Op,       
                Branch      => Branch,
                ALUOp       => ALUOp,
                RegW        => s_regW,
                MemW        => MemW,
                MemToReg    => MemToReg,
                AluSrc      => AluSrc,                
                ImmSrc      => ImmSrc,
                RegSrc      => RegSrc,
                Link        => Link
                );         

    ALU_decoder : entity work.ALU_decoder
    port map(
                ALUOp       => ALUOp,
                Funct4_0     => Funct(4 downto 0),
                ALUControl  => ALUControl,
                FlagW       => FlagW,
                noWrite => noWrite_s
                );
               
    RegW <= s_regW and not noWrite_s;

end structural;
