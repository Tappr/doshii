require './test/test_helper'

class CheckinTest < Minitest::Test
  include BaseTest

  def test_that_it_returns_a_table
    create_table
    VCR.use_cassette('table/find') do
      table = Doshii.table.find @table.body.id
      assert table.body.id     == @table.body.id
      assert table.body.name   == @table.body.name
      assert table.body.status == @table.body.status
    end
  end
end
