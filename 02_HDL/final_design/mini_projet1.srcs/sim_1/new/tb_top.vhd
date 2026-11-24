----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2026 08:48:12 PM
-- Design Name: 
-- Module Name: tb_top - Behavioral
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
use ieee.std_logic_textio.all;
use std.textio.all;
use std.env.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is
    constant T           : time := 10 ns;
 
    signal clk           : std_logic := '0';
    signal reset         : std_logic := '1';
    signal ALUResult     : std_logic_vector(31 downto 0);
    signal exp_ALUResult : std_logic_vector(31 downto 0) := (others => '0');
    signal WriteData     : std_logic_vector(31 downto 0);
    signal exp_WriteData : std_logic_vector(31 downto 0) := (others => '0');
begin
    clk   <= not clk after T/2;
    reset <= '1', '0' after 22 ns;
 
    DUT : entity work.top
        port map (
            clk       => clk,
            reset     => reset,
            ALUResult => ALUResult,
            WriteData => WriteData
        );
 
    process
        file     f        : text;
        variable l        : line;
        variable sep      : character;
        variable exp_alu  : std_logic_vector(31 downto 0);
        variable exp_data : std_logic_vector(31 downto 0);
        variable n_vec    : integer := 0;
        variable n_err    : integer := 0;
        variable err_alu  : boolean;
        variable err_data : boolean;
    begin
        file_open(f, "ExpectedData.txt", read_mode);
 
        wait until reset = '0';
        wait for 1 ns;
 
    while not endfile(f) loop
        readline(f, l);
        if l'length > 0 then
    
            if n_vec > 0 then
                wait until rising_edge(clk);
            end if;
    
            read(l, exp_alu);
            read(l, exp_data);
            exp_ALUResult <= exp_alu;
            exp_WriteData <= exp_data;
            n_vec := n_vec + 1;
    
            if n_vec = 1 then
                wait for 1 ns;
            else
                wait for T/2 - 1 ns;
            end if;
    
            err_alu  := (ALUResult /= exp_alu);
            err_data := (WriteData /= exp_data);
    
            if err_alu or err_data then
                n_err := n_err + 1;
                report "Instruction " & integer'image(n_vec - 1) & " ECHEC"
                     & " | ALUResult attendu=" & to_hstring(exp_alu)
                     & " observé="     & to_hstring(ALUResult)
                     & " | WriteData attendu=" & to_hstring(exp_data)
                     & " observé="     & to_hstring(WriteData)
                     severity error;
            end if;
    
        end if;
    end loop;
 
        file_close(f);
 
        if n_err = 0 then
            report "===== RESUME =====" & LF &
                   "Instructions verifiees : " & integer'image(n_vec) & LF &
                   "Instructions en erreur : " & integer'image(n_err) & LF &
                   "TOUS LES TESTS ONT REUSSI";
        else
            report "===== RESUME =====" & LF &
                   "Instructions verifiées : " & integer'image(n_vec) & LF &
                   "Instructions en erreur : " & integer'image(n_err) & LF &
                   "ECHEC : " & integer'image(n_err) & " instruction(s) en erreur"
                severity failure;
        end if;
 
        stop;
        wait;
    end process;
 
end Behavioral;
