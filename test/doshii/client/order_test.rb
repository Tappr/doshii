require './test/test_helper'

class OrderTest < Minitest::Test
  CLIENT = Doshii::Client.new
  CREATE_LOCATION_PARAMS =
    {
      name: "Chicken's R Us", mobility: 'fixed', availability: 'closed',
      address_line1: '608 St Kilda Rd', city: 'Melbourne', state: 'VIC',
      postalCode: '3000', country: 'AU', phoneNumber: '(03) 9005 4950',
      latitude: '-37.814107', longitude: '144.96327999999994'
    }
  CREATE_CHECKIN_PARAMS =
    {
      name: 'John Smith', externalId: 'ias2kk2',
      photoURL: 'http://example.com/profile.png',
    }
  CREATE_ORDER_PARAMS =
    {
      tip: '100', status: 'pending',
      items: [{
        id: '2', pos_id: 'lol12', name: 'Toasted Sourdough Bread & Eggs',
        price: 1100, description: 'Just ye old classic', status: 'pending'
      }]
    }

  def setup
    VCR.use_cassette('location/create_location') do
      @location = CLIENT.create_location do |p|
        p.merge!(CREATE_LOCATION_PARAMS)
      end
    end
    VCR.use_cassette('create_checkin') do
      @checkin = CLIENT.create_checkin @location['body']['id'], CREATE_CHECKIN_PARAMS
    end
  end

  def teardown
    VCR.use_cassette('delete_checkin') do
      CLIENT.delete_checkin @checkin['id']
    end
  end

  def test_that_it_exists
    assert defined?(Doshii::Client::Order)
  end

  def test_that_it_creates_order
    VCR.use_cassette('create_order') do
      result = CLIENT.create_order @checkin['body']['id'], CREATE_ORDER_PARAMS

      # asserts here
    end
  end
end
