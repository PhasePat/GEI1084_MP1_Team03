----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 05:54:51 PM
-- Design Name: 
-- Module Name: ALU_decoder - behavioral
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

entity ALU_decoder is
  Port(
        ALUOp       : in std_logic;
        Funct4_0    : in std_logic_vector(4 downto 0);
        
        ALUControl,
        FlagW       : out std_logic_vector(1 downto 0)
        );
end ALU_decoder;

architecture behavioral of ALU_decoder is
    alias Funct4_1 : std_logic_vector(3 downto 0) is Funct4_0(4 downto 1);
    alias Funct0   : std_logic is Funct4_0(0);
begin
    process(all)
    begin
    
        if ALUOp then
            case Funct4_1 is
                when "0100" =>
                    ALUControl <= "00";
                when "0010" => 
                    ALUControl <= "01";
                when "0000" => 
                    ALUControl <= "10"; 
                when "1100" => 
                    ALUControl <= "11";
                when others => 
                    ALUControl <= "00"; 
            end case;

            if Funct0 then
                case Funct4_1 is
                    when "0100" | "0010" =>
                        FlagW <= "11";
                    when "0000" | "1100" => 
                        FlagW <= "10";
                    when others => 
                        FlagW <= "00";
                end case;
            else
                FlagW      <= "00";
            end if;
        else
            ALUControl <= "00";
            FlagW      <= "00";
        end if;
    end process;

end behavioral;
