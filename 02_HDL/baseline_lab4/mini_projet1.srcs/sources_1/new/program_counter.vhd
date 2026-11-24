----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2026 06:58:49 PM
-- Design Name: 
-- Module Name: program_counter - structural
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

entity program_counter is
  Port(
        clk,
        reset       : in std_logic;
        
        PCNext      : in std_logic_vector(31 downto 0);
        
        PC, 
        PCPlus4, 
        PCPlus8     : out STD_LOGIC_VECTOR(31 downto 0)
        );
end program_counter;

architecture structural of program_counter is
    signal  PC_s,
            PCPlus4_s,
            PCPlus8_s   : STD_LOGIC_VECTOR(31 downto 0);
    constant four       : STD_LOGIC_VECTOR(31 downto 0) := x"00000004";
begin
    pcreg : entity work.flopenr generic map (32)
    port map(
                clk => clk,
                reset => reset,
                en => '1',
                d => PCNext,
                q => PC_s
                );
                
    add4 : entity work.adder 
    port map(
                a => PC_s,
                b => four, 
                y => PCPlus4_s
                );
                
    add8 : entity work.adder 
    port map(
                a => PCPlus4_s,
                b => four,
                y => PCPlus8_s
                );
                
    PC <= PC_s;
    PCPlus4 <= PCPlus4_s;
    PCPlus8 <= PCPlus8_s;

end structural;
