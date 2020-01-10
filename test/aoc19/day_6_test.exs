defmodule OrbitMapTest do
  use ExUnit.Case

  describe "acceptance" do
    @describetag :acceptance

    test "generates checksum" do
      assert OrbitMap.checksum(
        "COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L") == 42
    end
  end
end
