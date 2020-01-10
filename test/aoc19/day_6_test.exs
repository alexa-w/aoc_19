defmodule OrbitMapTest do
  use ExUnit.Case

  describe "acceptance" do
    @describetag :acceptance

    test "marshals data" do
      assert OrbitMap.marshal(
        "COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L"
      ) == ["COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"]
    end

    test "generates checksum" do
      assert OrbitMap.checksum(
        ["COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"]
      ) == 42
    end
  end
end
