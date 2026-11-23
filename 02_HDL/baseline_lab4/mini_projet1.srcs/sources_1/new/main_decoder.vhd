----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 04:32:59 PM
-- Design Name: 
-- Module Name: main_decoder - behavioral
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

entity main_decoder is
  Port( 
        Funct5,
        Funct4,
        Funct0      : in std_logic;
        
        Op          : in std_logic_vector(1 downto 0);

        Branch,
        Link,
        ALUOp,
        RegW,
        MemW,
        MemToReg,
        AluSrc      : out std_logic;
        
        ImmSrc,
        RegSrc      : out std_logic_vector(1 downto 0)
        );
end main_decoder;

architecture behavioral of main_decoder is
begin
  
    process(all) begin
        Branch      <= '0';
        ALUOp       <= '0';
        RegW        <= '0';
        MemW        <= '0';
        MemToReg    <= '0';
        AluSrc      <= '0';
        Link        <= '0';
        ImmSrc      <= "00";
        RegSrc      <= "00";
        
        case Op is
            when "00" =>
                AluSrc      <= Funct5;
                RegW        <= '1';
                ALUOp       <= '1';
            when "01" =>
                MemToReg    <= Funct0;
                MemW        <= not Funct0;
                ALUSrc      <= '1';
                ImmSrc      <= "01";
                RegW        <= Funct0;
                RegSrc(1)   <= not Funct0;
            when "10" =>
                Branch      <= '1';
                ALUSrc      <= '1';
                ImmSrc      <= "10";
                RegSrc      <= "01";
                RegW        <= Funct4;
                Link        <= Funct4;
            when others =>
                Branch      <= '0';
                ALUOp       <= '0';
                RegW        <= '0';
                MemW        <= '0';
                MemToReg    <= '0';
                AluSrc      <= '0';
                Link        <= '0';
                ImmSrc      <= "00";
                RegSrc      <= "00";
        end case;
        
    end process;

end behavioral;
