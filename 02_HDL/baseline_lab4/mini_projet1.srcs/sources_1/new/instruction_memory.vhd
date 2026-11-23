----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/11/2026 08:00:18 PM
-- Design Name: 
-- Module Name: instruction_memory - behavioral
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
use STD.TEXTIO.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_memory is
  generic(InstructionFile : string := "Instructions.txt");
  port(
        A  : in  STD_LOGIC_VECTOR(31 downto 0);
        RD : out STD_LOGIC_VECTOR(31 downto 0)
        );
end;

architecture behavioral of instruction_memory is
  type ramtype is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
  signal mem : ramtype := (others => (others => '0'));
begin
  process
    file     f : text;
    variable l : line;
    variable w : std_logic_vector(31 downto 0);
    variable i : integer := 0;
  begin
    file_open(f, InstructionFile, read_mode);
    while not endfile(f) loop
      readline(f, l);
      read(l, w);
      mem(i) <= w;
      i := i + 1;
    end loop;
    file_close(f);
    wait;
  end process;

  RD <= mem(to_integer(unsigned(A(6 downto 2))));
end;