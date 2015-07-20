require './test/test_helper'

class CheckinTest < Minitest::Test
  include BaseTest

  def setup
    create_checkin
  end

  def test_that_it_exists
    assert defined?(Doshii.checkin)
  end

  def test_that_it_returns_a_checkin
    VCR.use_cassette('checkin/find') do
      checkin = Doshii.checkin.find @checkin.id
      assert checkin.id     == @checkin.id
      assert checkin.status == @checkin.status
    end
  end

  def test_that_it_returns_not_found
    VCR.use_cassette('checkin/find_not_found') do
      checkin = Doshii.checkin.find 19999991
      assert checkin.status     == 404
      assert checkin.message    == 'Checkin Not found'
      assert checkin.statusCode == 404
    end
  end

  def test_that_it_creates_checkin
    assert @checkin.respond_to?(:id)
    assert @checkin.locationId == @location.id
  end

  def test_that_create_fails_when_invalid_params
    VCR.use_cassette('checkin/create_invalid_params') do
      checkin = Doshii.checkin.create @location.id
      assert checkin.name == 'SequelizeValidationError'
      assert checkin.message.include?('notNull Violation')
    end
  end

  def test_that_it_deletes_checkin
    VCR.use_cassette('checkin/create2') do
      @checkin2 = Doshii.checkin.create @location.id do |p|
        p.merge!(CREATE_CHECKIN_PARAMS2)
      end
    end
    VCR.use_cassette('checkin/delete') do
      checkin = Doshii.checkin.delete @checkin2.id
      assert checkin.status == 200
      assert checkin.body.empty?
    end
  end

  def test_that_it_allocates_a_table
    create_table
    assert @table.respond_to?(:id)
    assert @table.name   == '3'
    assert @table.status == 'waiting_for_confirmation'
  end

  def test_that_it_does_not_allocate_a_table_when_existing
    VCR.use_cassette('checkin/table_conflict') do
      table = Doshii.checkin.create "#{@checkin.id}/table" do |p|
        p[:name] = '3'
      end
      assert table.status  == 409
      assert table.message == 'Table allocation already exists for checkin'
    end
  end

  # def test_that_it_updates_a_checkin
  #   VCR.use_cassette('checkin/create3') do
  #     @checkin4 = Doshii.checkin.create @location.id do |p|
  #       p.merge!(CREATE_CHECKIN_PARAMS3)
  #     end
  #   end
  #   new_status = 'cancelled'
  #   assert @checkin3.status != new_status
  #   VCR.use_cassette('checkin/update') do
  #     checkin = Doshii.checkin.update @checkin3.id do |p|
  #       p[:status] = new_status
  #     end
  #     assert checkin.status == new_status
  #   end
  # end
end
