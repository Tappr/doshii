require './test/test_helper'

class CheckinTest < Minitest::Test
  include BaseTest

  def setup
    create_location
    create_checkin
  end

  def test_that_it_exists
    assert defined?(Doshii::Client.checkin)
  end

  def test_that_it_returns_a_checkin
    VCR.use_cassette('checkin/find') do
      checkin = Doshii::Client.checkin.find @checkin.body['id']
      assert checkin.status == 200
      assert checkin.body['id'] == @checkin.body['id']
      assert checkin.body['status'] == @checkin.body['status']
    end
  end

  def test_that_it_returns_not_found
    VCR.use_cassette('checkin/find_not_found') do
      checkin = Doshii::Client.checkin.find 19999991
      assert checkin.status == 404
      assert checkin.body['message'] == 'Checkin Not found'
      assert checkin.body['statusCode'] == 404
    end
  end

  def test_that_it_creates_checkin
    assert @checkin.status == 200
    assert @checkin.body.has_key?('id')
    assert @checkin.body['locationId'] == @location.body['id']
  end

  def test_that_create_fails_when_invalid_params
    VCR.use_cassette('checkin/create_invalid_params') do
      checkin = Doshii::Client.checkin.create @location.body['id']
      assert checkin.status == 500
      assert checkin.body['name'] == 'SequelizeValidationError'
      assert checkin.body['message'].include?('notNull Violation')
    end
  end

  def test_that_it_deletes_checkin
    VCR.use_cassette('checkin/delete') do
      checkin = Doshii::Client.checkin.delete @checkin.body['id']
      assert checkin.status == 200
      assert checkin.body.empty?
    end
  end

  private

  def create_checkin
    VCR.use_cassette('checkin/create') do
      @checkin = Doshii::Client.checkin.create @location.body['id'] do |p|
        p.merge!(CREATE_CHECKIN_PARAMS)
      end
    end
  end

  def create_location
    VCR.use_cassette('location/create') do
      @location = Doshii::Client.location.create do |p|
        p.merge!(CREATE_LOCATION_PARAMS)
      end
    end
  end
end
