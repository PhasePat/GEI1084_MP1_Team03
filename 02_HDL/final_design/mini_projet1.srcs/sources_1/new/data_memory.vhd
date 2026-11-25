----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2026 04:39:35 PM
-- Design Name: 
-- Module Name: data_memory - behavioral
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

entity data_memory is
    generic(N : integer := 6; M : integer := 32);
    Port(   
            clk : in std_logic;
            WE  : in std_logic := '0';
            
            A,
            WD  : in std_logic_vector(M-1 downto 0);
            
            RD  : out std_logic_vector(M-1 downto 0)
            );
end data_memory;

architecture behavioral of data_memory is
    type memory_array is array((2**N-1) downto 0) of std_logic_vector(M-1 downto 0);
    Signal mem : memory_array := (others => (others => '0'));
begin

    process(clk) begin
        if rising_edge(clk) then
            if WE = '1' then
                mem(to_integer(unsigned(A(N-1 downto 0)))) <= WD;
            end if;
        end if;
    end process;
    
    RD <= mem(to_integer(unsigned(A(N-1 downto 0))));

end behavioral;
