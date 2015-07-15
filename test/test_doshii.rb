require './test/test_helper'

class TestDoshii < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Doshii::VERSION
  end
end
