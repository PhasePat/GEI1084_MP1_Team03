----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2026 04:10:42 PM
-- Design Name: 
-- Module Name: register_file - behavioral
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

entity register_file is
    generic(N : integer := 4; M : integer := 32);
    port(   
            clk : in std_logic;
            WE3 : in std_logic := '0';
            
            A1, 
            A2, 
            A3  : in std_logic_vector(N-1 downto 0);
            
            WD3, 
            R15 : in std_logic_vector(M-1 downto 0);
            
            RD1, 
            RD2 : out std_logic_vector(M-1 downto 0)
            );
end register_file;

architecture behavioral of register_file is
    type register_array is array((2**N-1) downto 0) of std_logic_vector(M-1 downto 0);
    Signal reg : register_array := (others => (others => '0'));
begin

    process(clk) begin
        if rising_edge(clk) then
            if WE3 then
                reg(to_integer(unsigned(A3))) <= WD3;
            end if;
            
            
        end if;
    end process;
    
    RD1 <= R15 when A1 = x"F" else reg(to_integer(unsigned(A1)));
    
    RD2 <= R15 when A2 = x"F" else reg(to_integer(unsigned(A2)));

end Behavioral;

