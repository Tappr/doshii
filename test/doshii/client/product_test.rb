require './test/test_helper'

class LocationTest < Minitest::Test
  def test_that_it_exists
    assert defined?(Doshii::Client.product)
  end

  def test_that_it_returns_a_product
    VCR.use_cassette('product/find') do
      product = Doshii::Client.product.find 1
      assert product.status == 200
      assert product.body.size > 0
      product.body.each do |p|
        assert p.has_key?('id')
        assert p.has_key?('name')
        assert p.has_key?('price')
      end
    end
  end
end
