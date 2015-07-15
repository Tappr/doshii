require './test/test_helper'

class LocationTest < Minitest::Test
  def test_that_it_exists
    assert defined?(Doshii::Location)
  end

  def test_that_it_returns_all_locations
    VCR.use_cassette('all_locations') do
      result = Doshii::Location.all

      assert result.length > 0
      assert result.kind_of?(Array)
      assert result.first.kind_of?(Doshii::Location)
    end
  end
end
