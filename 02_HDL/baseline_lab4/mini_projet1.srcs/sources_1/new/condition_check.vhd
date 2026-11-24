----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2026 06:01:08 PM
-- Design Name: 
-- Module Name: condition_check - Behavioral
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

entity condition_check is
  Port(
        Flag_N_Z,
        Flag_C_V    : in std_logic_vector(1 downto 0);
        
        Cond        : in std_logic_vector(3 downto 0);
        
        CondEx      : out std_logic
        );
end condition_check;

architecture Behavioral of condition_check is
    signal  n,
            z, 
            c, 
            v, 
            n_eq_v : STD_LOGIC;
begin
    n <= Flag_N_Z(1);
    z <= Flag_N_Z(0);
    c <= Flag_C_V(1);
    v <= Flag_C_V(0);
    n_eq_v <= not (n xor v);
    
    process (all) begin
        
        case Cond is
          when "0000" => 
            CondEx <= z;
          when "0001" => 
            CondEx <= not z;
          when "0010" => 
            CondEx <= c;
          when "0011" => 
            CondEx <= not c;
          when "0100" => 
            CondEx <= n;
          when "0101" => 
            CondEx <= not n;
          when "0110" => 
            CondEx <= v;
          when "0111" => 
            CondEx <= not v;
          when "1000" => 
            CondEx <= c and not z;
          when "1001" => 
            CondEx <= not (c and not z);
          when "1010" => 
            CondEx <= n_eq_v;
          when "1011" => 
            CondEx <= not n_eq_v;
          when "1100" => 
            CondEx <= (not z) and n_eq_v;
          when "1101" => 
            CondEx <= not ((not z) and n_eq_v);
          when "1110" => 
            CondEx <= '1';
          when others => 
            CondEx <= '0';
        end case;
        
  end process;

end Behavioral;
