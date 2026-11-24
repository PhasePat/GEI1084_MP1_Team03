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
-- Module Name: tb_top - Behavioral
-- Description: Runs ALL tests (cmp, shift, bl, default) in a single simulation.
--              One DUT instance per test, same clock/reset, one checker each.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;

entity tb_top is
end tb_top;

architecture Behavioral of tb_top is
    type test_t is (T_CPM, T_SHIFT, T_BL, T_DEFAULT);

    constant N_TESTS : integer := test_t'pos(test_t'right) + 1;
    constant T       : time    := 10 ns;

    -- Folder containing the *_inst.txt / *_exp.txt files, relative to
    -- <project>.sim/sim_1/behav/xsim/
    constant TEST_DIR : string := "../../../../tests/";

    function test_name(num : test_t) return string is
    begin
        case num is
            when T_CPM      => return "cmp";
            when T_SHIFT    => return "shift";
            when T_BL       => return "bl";
            when others     => return "default";
        end case;
    end function;

    type slv_array is array (0 to N_TESTS - 1) of std_logic_vector(31 downto 0);
    type int_array is array (0 to N_TESTS - 1) of integer;

    signal clk           : std_logic := '0';
    signal reset         : std_logic := '1';

    signal ALUResult     : slv_array;
    signal WriteData     : slv_array;
    signal exp_ALUResult : slv_array := (others => (others => '0'));
    signal exp_WriteData : slv_array := (others => (others => '0'));

    signal done          : std_logic_vector(0 to N_TESTS - 1) := (others => '0');
    signal n_vec_s       : int_array := (others => 0);
    signal n_err_s       : int_array := (others => 0);

    constant ALL_DONE    : std_logic_vector(0 to N_TESTS - 1) := (others => '1');
begin
    clk   <= not clk after T/2;
    reset <= '1', '0' after 22 ns;

    gen_tests : for i in 0 to N_TESTS - 1 generate
        constant NAME      : string := test_name(test_t'val(i));
        constant INST_FILE : string := TEST_DIR & NAME & "_inst.txt";
        constant EXP_FILE  : string := TEST_DIR & NAME & "_exp.txt";
    begin

        DUT : entity work.top
            generic map (InstructionFile => INST_FILE)
            port map (
                clk       => clk,
                reset     => reset,
                ALUResult => ALUResult(i),
                WriteData => WriteData(i)
            );

        checker : process
            file     f        : text;
            variable l        : line;
            variable exp_alu  : std_logic_vector(31 downto 0);
            variable exp_data : std_logic_vector(31 downto 0);
            variable n_vec    : integer := 0;
            variable n_err    : integer := 0;
            variable err_alu  : boolean;
            variable err_data : boolean;
        begin
            file_open(f, EXP_FILE, read_mode);

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
                    exp_ALUResult(i) <= exp_alu;
                    exp_WriteData(i) <= exp_data;
                    n_vec := n_vec + 1;

                    if n_vec = 1 then
                        wait for 1 ns;
                    else
                        wait for T/2 - 1 ns;
                    end if;

                    err_alu  := (ALUResult(i) /= exp_alu);
                    err_data := (WriteData(i) /= exp_data);

                    if err_alu or err_data then
                        n_err := n_err + 1;
                        report "[" & NAME & "] Instruction " & integer'image(n_vec - 1) & " ECHEC"
                             & " | ALUResult attendu=" & to_hstring(exp_alu)
                             & " observé="     & to_hstring(ALUResult(i))
                             & " | WriteData attendu=" & to_hstring(exp_data)
                             & " observé="     & to_hstring(WriteData(i))
                             severity error;
                    end if;

                end if;
            end loop;

            file_close(f);

            if n_err = 0 then
                report "[" & NAME & "] OK : " & integer'image(n_vec) & " instructions verifiees";
            else
                report "[" & NAME & "] ECHEC : " & integer'image(n_err) & " / "
                       & integer'image(n_vec) & " instruction(s) en erreur"
                       severity error;
            end if;

            n_vec_s(i) <= n_vec;
            n_err_s(i) <= n_err;
            done(i)    <= '1';
            wait;
        end process checker;

    end generate gen_tests;

    summary : process
        variable tot_vec : integer := 0;
        variable tot_err : integer := 0;
    begin
        wait until done = ALL_DONE;

        for k in 0 to N_TESTS - 1 loop
            tot_vec := tot_vec + n_vec_s(k);
            tot_err := tot_err + n_err_s(k);
        end loop;

        if tot_err = 0 then
            report "===== RESUME =====" & LF &
                   "Tests executes         : " & integer'image(N_TESTS) & LF &
                   "Instructions verifiees : " & integer'image(tot_vec) & LF &
                   "Instructions en erreur : " & integer'image(tot_err) & LF &
                   "TOUS LES TESTS ONT REUSSI";
        else
            report "===== RESUME =====" & LF &
                   "Tests executes         : " & integer'image(N_TESTS) & LF &
                   "Instructions verifiees : " & integer'image(tot_vec) & LF &
                   "Instructions en erreur : " & integer'image(tot_err) & LF &
                   "ECHEC : " & integer'image(tot_err) & " instruction(s) en erreur"
                severity failure;
        end if;

        wait;
    end process summary;

end Behavioral;