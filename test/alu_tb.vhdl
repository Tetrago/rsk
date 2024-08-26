library ieee;
  use ieee.std_logic_1164.all;

library work;
  use work.alu_pkg.all;

entity alu_tb is
end entity alu_tb;

architecture behave of alu_tb is

  signal r_x      : std_logic_vector(3 downto 0);
  signal r_y      : std_logic_vector(3 downto 0);
  signal s_result : std_logic_vector(3 downto 0);
  signal r_op     : alu_op;
  signal s_c, r_c : std_logic;

begin

  alu_0 : alu
    generic map (
      width => 4
    )
    port map (
      x_i      => r_x,
      y_i      => r_y,
      c_i      => r_c,
      op_i     => r_op,
      result_o => s_result,
      c_o      => s_c
    );

  process
    type pattern is record
        x, y, result : std_logic_vector(3 downto 0);
        op : alu_op;
        c_i, c_o : std_logic;
    end record pattern;

    type pattern_array is array (natural range <>) of pattern;

    constant patterns : pattern_array := (
      ("0001", "0001", "0010", alu_add, '0', '0'),
      ("1000", "1000", "0000", alu_add, '0', '1'),
      ("1010", "1100", "1000", alu_and, '0', '0'),
      ("1010", "1100", "1110", alu_or,  '0', '0'),
      ("1010", "XXXX", "0100", alu_rol, '0', '1'),
      ("1010", "XXXX", "0101", alu_rol, '1', '1'),
      ("0101", "XXXX", "0010", alu_ror, '0', '1'),
      ("0101", "XXXX", "1010", alu_ror, '1', '1'),
      ("0101", "XXXX", "0010", alu_asr, '0', '1'),
      ("1101", "XXXX", "1110", alu_asr, '0', '1'),
      ("1010", "XXXX", "0100", alu_lsl, '1', '1'),
      ("0101", "XXXX", "0010", alu_lsr, '1', '1')
    );
  begin
    for i in patterns'range loop
      r_x <= patterns(i).x;
      r_y <= patterns(i).y;
      r_op <= patterns(i).op;
      r_c <= patterns(i).c_i;
      wait for 1 ns;

      assert s_result = patterns(i).result report "bad result" severity error;
      assert s_c = patterns(i).c_o report "bad carry" severity error;
    end loop;

    assert false report "end of test" severity note;
    wait;
  end process;

end architecture behave;
