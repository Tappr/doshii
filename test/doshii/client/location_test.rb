require './test/test_helper'

class LocationTest < Minitest::Test
  include BaseTest

  def test_that_it_exists
    assert defined?(Doshii.location)
  end

  def test_that_create_fails_when_invalid_params
    VCR.use_cassette('location/create_invalid_params') do
      location = Doshii.location.create
      assert location.name == 'SequelizeValidationError'
      assert location.message.include?('notNull Violation')
    end
  end

  def test_that_it_creates_location
    create_location
    assert @location.respond_to?(:id)
    assert @location.name == CREATE_LOCATION_PARAMS[:name]
    assert @location.city == CREATE_LOCATION_PARAMS[:city]
  end

  def test_that_it_returns_all_locations
    VCR.use_cassette('location/all') do
      locations = Doshii.location.all
      refute_empty locations
      assert_kind_of Array, locations
      locations.each do |loc|
        assert loc.respond_to?(:id)
        assert loc.respond_to?(:name)
        assert loc.respond_to?(:city)
      end
    end
  end
end
