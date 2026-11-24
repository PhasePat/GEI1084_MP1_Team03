----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/13/2026 05:43:10 PM
-- Design Name: 
-- Module Name: datapath - structural
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

entity datapath is
    generic(
            InstructionFile : string := "Instructions.txt";
            N : integer := 4;
            M : integer := 32);
  Port(
        clk,
        reset,
        Link,
        MemToReg,
        MemWrite,
        ALUSrc,
        RegWrite,
        PCSrc           : in std_logic;  
             
        ALUControl,
        ImmSrc,
        RegSrc          : in std_logic_vector(1 downto 0);
              
        ALUFlags        : out std_logic_vector(N-1 downto 0);
        
        InStr,
        WriteData_out,
        ALUResult_out   : out std_logic_vector(M-1 downto 0) 
        );
end datapath;

architecture structural of datapath is
    signal RA1,
           RA2,
           RA3              : std_logic_vector(N-1 downto 0);
           
    signal  SrcA,
            SrcB,
            RD2,
            WD3,
            ExtImm,
            ALUResult,
            ReadData,
            Result,           
            PCNext,
            PC,
            PCPlus4,
            PCPlus8         : std_logic_vector(M-1 downto 0); 
    
    signal IsrRD2           : std_logic_vector(M-1 downto 0);
    
begin
    register_file : entity work.register_file 
    port map(   
                clk     => clk,
                WE3     => RegWrite,
                A1      => RA1,
                A2      => RA2,
                A3      => RA3,
                WD3     => WD3,
                R15     => PCPlus8,
                RD1     => SrcA,
                RD2     => RD2
                );
                
    extend : entity work.extend
    port map(   
                InStr   => InStr(23 downto 0),
                ImmSrc  => ImmSrc,
                ExtImm  => ExtImm
                );
                
    ALU : entity work.ALU
    port map(   
                A           => SrcA,
                B           => SrcB,
                ALUControl  => ALUControl,
                ALUFlags    => ALUFlags,
                result      => ALUResult
                );
                
    data_memory : entity work.data_memory
    port map(   
                clk         => clk,
                WE          => MemWrite,
                A           => ALUResult,
                WD          => RD2,
                RD          => ReadData
                );
                
    program_counter : entity work.program_counter
    port map(
                clk => clk,
                reset => reset,
                PCNext => PCNext,
                PC => PC,
                PCPlus4 => PCPlus4,
                PCPlus8 => PCPlus8
                );
                
    instruction_memory : entity work.instruction_memory
    generic map (InstructionFile => InstructionFile)
    port map(
                A   => PC,
                RD  => Instr
                );
    
    isr : entity work.ISR
    port map(
                A      => RD2,
                shamt  => InStr(11 downto 7),
                sh     => InStr(6 downto 5),
                Y      => IsrRD2
                );

    RA1     <= x"F" when RegSrc(0) = '1' else InStr(19 downto 16);

    RA2     <= InStr(15 downto 12) when RegSrc(1) = '1' else InStr(3 downto 0);

    SrcB    <= ExtImm when ALUSrc = '1' else IsrRD2; -- mathieu: je l'ai modifi� pour inclure l'ISR
    -- car il va vers SrcB quand ALUSrc est 0 dans le multiplexeur
    
    Result  <= ReadData when MemToReg = '1' else ALUResult;
    
    PCNext  <= Result when PCSrc = '1' else PCPlus4;
    
    RA3     <= x"E" when Link = '1' else Instr(15 downto 12);
    
    WD3     <= PCPlus4 when Link = '1' else Result;
    
    
    ALUResult_out <= ALUResult;
    WriteData_out <= RD2;
         
end structural;
