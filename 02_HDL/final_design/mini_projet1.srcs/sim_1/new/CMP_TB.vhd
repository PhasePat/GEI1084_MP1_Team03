----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2026 03:00:30 PM
-- Design Name: 
-- Module Name: CMP_TB - Behavioral
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

entity CMP_TB is
--  Port ( );
end CMP_TB;

architecture Behavioral of CMP_TB is

    signal Op_s : std_logic_vector(1 downto 0) := (others => '0');
    signal Cond_s,
 Rd_s : std_logic_vector(3 downto 0) := (others => '0');
    signal Funct_s : std_logic_vector(5 downto 0) := (others => '0');
    signal PCS_s, 
MemToReg_s,
 MemW_s,
 ALUSrc_s,
 RegW_s : std_logic := '0';
    signal ALUControl_s,
 ImmSrc_s,
 RegSrc_s,
 FlagW_s : std_logic_vector (1 downto 0) := (others => '0');
    
begin
    DUT : entity work.decoder
    port map(
        Op
 => Op_s,      
        Cond => Cond_s,
        Rd => Rd_s,
        Funct => Funct_s,
     
        PCS => PCS_s,
        MemToReg => MemToReg_s,
        MemW => MemW_s,
        ALUSrc => ALUSrc_s,
        RegW => RegW_s,
        ALUControl => ALUControl_s,
        ImmSrc => ImmSrc_s,
        RegSrc => RegSrc_s,
        FlagW => FlagW_s
    );

        stim_proc : process
    begin
        Cond_s <= "1110";   -- AL, non utilisé par le decoder
        Op_s   <= "00";     -- traitement de données
        Rd_s   <= "0001";   -- R1
        wait for 20 ns;

        -- 1) SUB : S = 0 -> soustraction, pas de flags, écrit Rd
        Funct_s <= "000100";
        wait for 20 ns;
        assert ALUControl_s = "01" and FlagW_s = "00" and RegW_s = '1' and PCS_s = '0'
            report "SUB incorrect" severity error;

        -- 2) SUBS : S = 1 -> soustraction, flags mis à jour, écrit Rd
        Funct_s <= "000101";
        wait for 20 ns;
        assert ALUControl_s = "01" and FlagW_s = "11" and RegW_s = '1' and PCS_s = '0'
            report "SUBS incorrect" severity error;

        -- 3) CMP : même ALU et mêmes flags que SUBS, mais n'écrit PAS Rd
        Funct_s <= "010101";
        wait for 20 ns;
        assert ALUControl_s = "01" and FlagW_s = "11" and RegW_s = '0' and PCS_s = '0'
            report "CMP incorrect" severity error;

        -- 4) SUBS avec Rd = PC -> écrit le PC, donc PCS = 1
        Rd_s    <= "1111";
        Funct_s <= "000101";
        wait for 20 ns;
        assert RegW_s = '1' and PCS_s = '1'
            report "SUBS Rd=PC incorrect" severity error;

        -- 5) CMP avec Rd = PC -> ne doit PAS provoquer de saut
        Funct_s <= "010101";
        wait for 20 ns;
        assert RegW_s = '0' and PCS_s = '0'
            report "CMP Rd=PC incorrect (saut non voulu)" severity error;

        report "Fin du test CMP" severity note;
        wait;
    end process;
end Behavioral;
