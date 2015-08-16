require './test/test_helper'

class OrderTest < Minitest::Test
  include BaseTest

  def setup
    create_order
  end

  def test_that_it_exists
    assert defined?(Doshii.order)
  end

  def test_that_it_returns_order
    VCR.use_cassette('order/find') do
      order = Doshii.order.find @order.id
      assert order.checkinId  == @checkin.id
      assert order.status     == CREATE_ORDER_PARAMS[:status]
      assert order.items.size == CREATE_ORDER_PARAMS[:items].size
    end
  end

  def test_that_it_creates_order
    assert @order.checkinId  == @checkin.id
    assert @order.status     == CREATE_ORDER_PARAMS[:status]
    assert @order.items.size == CREATE_ORDER_PARAMS[:items].size
  end

  def test_that_create_fails_when_invalid_params
    VCR.use_cassette('order/create_invalid_params') do
      Doshii.order.create @checkin.id
      raise 'Should throw Doshii::ResponseError'
    end
  rescue Doshii::ResponseError => e
    error = Doshii::Response[JSON.parse(e.message)]
    assert error.status == 400
    assert error.name   == 'BadRequest'
    assert error.message.include?('Validation Error')
    assert error.message.include?('required')
  end
end
