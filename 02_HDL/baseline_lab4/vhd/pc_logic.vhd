----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 03:57:13 PM
-- Design Name: 
-- Module Name: pc_logic - behavioral
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

entity pc_logic is
  Port( 
        Branch,
        RegW     : in std_logic;
       
        Rd       : in std_logic_vector(3 downto 0);

        PCS      : out std_logic
        );
end pc_logic;

architecture behavioral of pc_logic is
begin

    PCS <= '1' when (Rd = x"F" and ?? RegW) or ?? Branch else '0';
    
end behavioral;
