require './test/test_helper'

class LocationTest < Minitest::Test
  CLIENT = Doshii::Client.new
  CREATE_LOCATION_PARAMS =
    {
      name: "Chicken's R Us", mobility: 'fixed', availability: 'closed',
      address_line1: '608 St Kilda Rd', city: 'Melbourne', state: 'VIC',
      postalCode: '3000', country: 'AU', phoneNumber: '(03) 9005 4950',
      latitude: '-37.814107', longitude: '144.96327999999994'
    }

  def test_that_it_exists
    assert defined?(Doshii::Client::Location)
  end

  def test_that_it_fails_when_invalid_params
    VCR.use_cassette('location/create_location_invalid_params') do
      location = CLIENT.create_location
      assert location.status == 500
      assert location.body['name'] == 'SequelizeValidationError'
      assert location.body['message'].include?('notNull Violation')
    end
  end

  def test_that_it_creates_location_with_block
    VCR.use_cassette('location/create_location') do
      location = CLIENT.create_location do |p|
        p.merge!(CREATE_LOCATION_PARAMS)
      end
      assert location.status == 200
      assert location.body['name'] == CREATE_LOCATION_PARAMS[:name]
      assert location.body['city'] == CREATE_LOCATION_PARAMS[:city]
      assert location.body.has_key?('id')
    end
  end

  def test_that_it_returns_all_locations
    VCR.use_cassette('location/all_locations') do
      result = CLIENT.locations
      refute_empty result.body
      assert_kind_of Array, result.body
      result.body.each do |loc|
        assert loc.has_key?('id')
        assert loc.has_key?('name')
        assert loc.has_key?('city')
      end
    end
  end
end
