module BaseTest
  CREATE_LOCATION_PARAMS = {
    name: "Chicken's R Us", mobility: 'fixed', availability: 'closed',
    address_line1: '608 St Kilda Rd', city: 'Melbourne', state: 'VIC',
    postalCode: '3000', country: 'AU', phoneNumber: '(03) 9005 4950',
    latitude: '-37.814107', longitude: '144.96327999999994'
  }
  CREATE_CHECKIN_PARAMS = {
    name: 'John Smith', externalId: 'ias2kk2',
    photoURL: 'http://example.com/profile.png',
  }
  CREATE_CHECKIN_PARAMS2 = {
    name: 'William Smith', externalId: 'ias2kk3',
    photoURL: 'http://example.com/profile2.png',
  }
  CREATE_ORDER_PARAMS = {
    tip: '100', status: 'pending',
    items: [{
      id: '2', pos_id: 'toasted_bread', name: 'Toasted Sourdough Bread & Eggs',
      price: 1100, description: 'Just ye old classic', status: 'accepted'
    }]
  }

  protected

  def create_checkin
    VCR.use_cassette('checkin/create') do
      @checkin = Doshii.checkin.create @location.body['id'] do |p|
        p.merge!(CREATE_CHECKIN_PARAMS)
      end
    end
  end

  def create_location
    VCR.use_cassette('location/create') do
      @location = Doshii.location.create do |l|
        l.merge!(CREATE_LOCATION_PARAMS)
      end
    end
  end

  def create_order
    VCR.use_cassette('order/create') do
      @order = Doshii.order.create @checkin.body['id'] do |o|
        o.merge!(CREATE_ORDER_PARAMS)
      end
    end
  end
end
