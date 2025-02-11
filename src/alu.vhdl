library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

library work;
  use work.alu_pkg.all;

entity alu is
  generic (
    width_g : natural := 32
  );
  port (
    x_i      : in    std_logic_vector(width_g - 1 downto 0);
    y_i      : in    std_logic_vector(width_g - 1 downto 0);
    c_i      : in    std_logic;
    op_i     : in    alu_op;
    result_o : out   std_logic_vector(width_g - 1 downto 0);
    c_o      : out   std_logic
  );
end entity alu;

architecture rtl of alu is

  signal w_add : std_logic_vector(width_g downto 0);

begin

  w_add <= std_logic_vector(unsigned('0' & x_i) + unsigned('0' & y_i));

  result_o <= w_add(width_g - 1 downto 0) when op_i = alu_add else
              x_i and y_i when op_i = alu_and else
              x_i or y_i when op_i = alu_or else
              x_i(width_g - 2 downto 0) & c_i when op_i = alu_rol else
              c_i & x_i(width_g - 1 downto 1) when op_i = alu_ror else
              x_i(width_g - 1) & x_i(width_g - 1 downto 1) when op_i = alu_asr else
              x_i(width_g - 2 downto 0) & '0' when op_i = alu_lsl else
              '0' & x_i(width_g - 1 downto 1) when op_i = alu_lsr;

  c_o <= w_add(width_g) when op_i = alu_add else
         x_i(width_g - 1) when op_i = alu_rol or op_i = alu_lsl else
         x_i(0) when op_i = alu_ror or op_i = alu_asr or op_i = alu_lsr else
         c_i;

end architecture rtl;
