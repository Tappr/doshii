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

  # def test_that_it_updates_order
  #   tip_value    = '100'
  #   status_value = 'ready to pay'
  #   updated_at   = '2015-07-17T08:39:24.467Z'
  #   VCR.use_cassette('order/update') do
  #     order = Doshii.order.update @order.id do |o|
  #       o[:tip]       = tip_value
  #       o[:status]    = status_value
  #       o[:updatedAt] = updated_at
  #     end
  #     assert order.status == 200
  #     assert order.tip    == new_tip_value
  #     assert order.status == new_status_value
  #   end
  # end
end
