# Doshii
[![Gem Version](https://badge.fury.io/rb/doshii.svg)](http://badge.fury.io/rb/doshii)

A Doshii API wrapper gem. Refer to [alphasandbox.doshii.co](https://alphasandbox.doshii.co/docs/partner/api/) for Doshii's official API documentation.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doshii'
```
or
```ruby
gem 'doshii', :git => 'https://github.com/devrc-trise/doshii.git', :branch => 'develop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doshii


rock'n'roll

## Usage

There are two ways to use Doshii:

1. System wide shared configuration
2. Per instance configuration

### 1. System wide shared configuration

Run this to create configuration file ```config/initializers/doshii.rb```:

    $ rails g doshii:install

Change ```config/initializers/doshii.rb``` as necessary. You might want to set values in system env or environment files to differentiate development, test and production setup:
```ruby
Doshii.configure do |config|
  # you might want to set these values in environment files
  config.client_id     = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  config.client_secret = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
  config.base_url      = 'https://alphasandbox.doshii.co'
  config.verify_ssl    = false
  config.version       = 'v1'
end
```

**CHECKINS**

DELETE /checkins/:checkinId
```ruby
Doshii.checkin.delete :checkin_id
```
GET /checkins/:checkinId
```ruby
Doshii.checkin.find :checkin_id
```
POST /checkins/:locationId
```ruby
Doshii.checkin.create :location_id do |params|
  params[:name]       = 'John Smith'
  params[:externalId] = 'ias2kk2'
  params[:photoURL]   = 'http://example.com/profile.png'
end
```
or
```ruby
checkin_params = {
  name: 'John Smith',
  externalId: 'ias2kk2',
  photoURL: 'http://example.com/profile.png'
}
Doshii.checkin.create :location_id do |param|
  params.merge!(checkin_params)
end
```
POST /checkins/:checkinId/table
```ruby
Doshii.checkin.create "#{:checkin_id}/table" do |params|
  params[:name] = '3'
end
```
PUT /checkins/:checkinId
```ruby
client.checkin.update :checkin_id do |params|
  params[:status] = 'left'
end
```

**LOCATIONS**

GET /locations
```ruby
Doshii.location.all
```
POST /locations
```ruby
Doshii.location.create do |params|
  params[:name]          = 'Chickens R Us'
  params[:mobility]      = 'fixed'
  params[:availability]  = 'closed'
  params[:address_line1] = '608 St Kilda Rd'
  # see the official api page for complete list of available params
end
```

**ORDERS**

GET /orders/:orderId
```ruby
Doshii.order.find :order_id
```
POST /orders/:checkinId
```ruby
Doshii.order.create :checkin_id do |params|
  params[:status] = 'pending'
  params[:items]  = [
    {
      name: 'Toasted Sourdough Bread & Eggs'
      description: 'Just ye old classic'
      # ...
    }
    # ...
  ]
  # see the official api page for complete list of available params
end
```
PUT /orders/:orderId
```ruby
# sample - consumer wants to pay
Doshii.order.update :order_id do |params|
  params[:tip]       = '0'
  params[:status]    = 'ready to pay'
  params[:updatedAt] = '2015-05-20T23:32:58.526Z'
end
# sample - payment has been processed and order is updated to paid
Doshii.order.update :order_id do |params|
  params[:tip]           = '0'
  params[:status]        = 'ready to pay'
  params[:updatedAt]     = '2015-05-20T23:32:58.526Z'
  params[:transactionId] = '123'
  params[:invoiceId]     = '123'
end
```

**PRODUCTS**

GET /products/:locationId
```ruby
Doshii.product.find :location_id
```

**TABLES**

GET /tables/:tableId
```ruby
Doshii.table.find :table_id
```

### 2. Per instance configuration

Pass configuration when defining new instance
```ruby
client = Doshii::Client.new(
  client_id:     'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
  client_secret: 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy',
  base_url:      'https://alphasandbox.doshii.co', #default
  verify_ssl:    false, #default
  version:       'v1' #default
)
```

**CHECKINS**

DELETE /checkins/:checkinId
```ruby
client.delete_checkin :checkin_id
```
GET /checkins/:checkinId
```ruby
client.get_checkin :checkin_id
```
POST /checkins/:locationId
```ruby
client.create_checkin :location_id do |params|
  params[:name]       = 'John Smith'
  params[:externalId] = 'ias2kk2'
  params[:photoURL]   = 'http://example.com/profile.png'
end
```
or
```ruby
checkin_params = {
  name: 'John Smith',
  externalId: 'ias2kk2',
  photoURL: 'http://example.com/profile.png'
}
client.create_checkin :location_id do |param|
  params.merge!(checkin_params)
end
```
POST /checkins/:checkinId/table
```ruby
client.allocate_table "#{:checkin_id}/table" do |params|
  params[:name] = '3'
end
```
PUT /checkins/:checkinId
```ruby
client.update_checkin :checkin_id do |params|
  params[:status] = 'left'
end
```

**LOCATIONS**

GET /locations
```ruby
client.list_locations
```
POST /locations
```ruby
client.create_location do |params|
  params[:name]          = 'Chickens R Us'
  params[:mobility]      = 'fixed'
  params[:availability]  = 'closed'
  params[:address_line1] = '608 St Kilda Rd'
  # see the official api page for complete list of available params
end
```

**ORDERS**

GET /orders/:orderId
```ruby
client.get_order :order_id
```
POST /orders/:checkinId
```ruby
client.create_order :checkin_id do |params|
  params[:status] = 'pending'
  params[:items]  = [
    {
      name: 'Toasted Sourdough Bread & Eggs'
      description: 'Just ye old classic'
      # ...
    }
    # ...
  ]
  # see the official api page for complete list of available params
end
```
PUT /orders/:orderId
```ruby
# sample - consumer wants to pay
client.update_order :order_id do |params|
  params[:tip]       = '0'
  params[:status]    = 'ready to pay'
  params[:updatedAt] = '2015-05-20T23:32:58.526Z'
end
# sample - payment has been processed and order is updated to paid
client.update_order :order_id do |params|
  params[:tip]           = '0'
  params[:status]        = 'ready to pay'
  params[:updatedAt]     = '2015-05-20T23:32:58.526Z'
  params[:transactionId] = '123'
  params[:invoiceId]     = '123'
end
```

**PRODUCTS**

GET /products/:locationId
```ruby
client.list_products :location_id
```

**TABLES**

GET /tables/:tableId
```ruby
client.get_table :table_id
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/doshii/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
