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
end
