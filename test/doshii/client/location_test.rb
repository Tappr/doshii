require './test/test_helper'

class LocationTest < Minitest::Test
  include BaseTest

  def test_that_it_exists
    assert defined?(Doshii.location)
  end

  def test_that_create_fails_when_invalid_params
    VCR.use_cassette('location/create_invalid_params') do
      location = Doshii.location.create
      assert location.status == 500
      assert location.body['name'] == 'SequelizeValidationError'
      assert location.body['message'].include?('notNull Violation')
    end
  end

  def test_that_it_creates_location
    create_location
    assert @location.status == 200
    assert @location.body.has_key?('id')
    assert @location.body['name'] == CREATE_LOCATION_PARAMS[:name]
    assert @location.body['city'] == CREATE_LOCATION_PARAMS[:city]
  end

  def test_that_it_returns_all_locations
    VCR.use_cassette('location/all') do
      result = Doshii.location.all
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
