require './test/test_helper'

class CheckinTest < Minitest::Test
  include BaseTest

  def test_that_it_returns_a_table
    create_table
    VCR.use_cassette('table/find') do
      table = Doshii.table.find @table['id']
      assert table.id     == @table.id
      assert table.name   == @table.name
      assert table.status == @table.status
    end
  end
end
