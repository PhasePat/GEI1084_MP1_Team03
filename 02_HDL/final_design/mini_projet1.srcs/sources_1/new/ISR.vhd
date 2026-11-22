----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2026 06:40:19 PM
-- Design Name: 
-- Module Name: ISR - Behavioral
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

-- 31:28  27:26  25  24:21  20  19:16  15:12  11:7    6:5  4   3:0
-- cond   00     I=0 cmd    S   Rn     Rd     shamt5  sh   0   Rm


entity ISR is
  Port (A      : in  std_logic_vector(31 downto 0);  -- RD2
        shamt  : in  std_logic_vector(4 downto 0);   -- shamt, le Instr(11 downto 7), est quantité de décalage, de 0 à 31
        sh     : in  std_logic_vector(1 downto 0);   -- sh, le Instr(6 downto 5), quand	00 = LSL, 01 = LSR (10 ASR et 11 ROR sont pas inclu)
        Y      : out std_logic_vector(31 downto 0)   -- est l'opérande décalé
        );
end ISR;

-- le bit 4, au Instr(4), est à	0 pour un décalage immédiat ey c'est le seul cas supporté
-- le Rm, au Instr(3 downto 0), est un registre décalé qui est déjà sur RA2 quand RegSrc(1)=0
-- Pour la modification au chemin de donnée, la seul chose faite est d'ajouter l'ISR, ce document, 
-- entre le RD2 et le multiplexeur quand ALUSrc est 0 et pointe vers SrcB et ensuite l'ALU.
-- L'ISR introduit shamt5 et sh  dans le chemin mentionné. 

architecture Behavioral of ISR is

begin
    process(all) begin
        case sh is
            when "00" =>   -- LSL
                Y <= std_logic_vector(shift_left (unsigned(A), to_integer(unsigned(shamt))));
            when "01" =>   -- LSR logique : unsigned => remplissage par des 0
                Y <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(shamt))));
            when others => -- ASR/ROR hors spécification : on laisse passer A
                Y <= A;
        end case;
    end process;

end Behavioral;
