require './test/test_helper'

class LocationTest < Minitest::Test
  def test_that_it_exists
    assert defined?(Doshii.product)
  end

  def test_that_it_returns_a_product
    VCR.use_cassette('product/find') do
      product = Doshii.product.find 1
      assert product.size > 0
      product.each do |p|
        assert p.respond_to?(:id)
        assert p.respond_to?(:name)
        assert p.respond_to?(:price)
      end
    end
  end
end
