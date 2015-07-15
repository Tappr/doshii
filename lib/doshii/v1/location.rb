module Doshii
  class Location
    API_URL = 'https://alpha.doshii.co/partner/api/v1/locations'
    attr_accessor :id, :userId, :name, :mobility, :availability, :address_line1, :address_line2,
                  :city, :state, :country, :postalCode, :phoneNumber, :token, :latitude, :longitude,
                  :checkinDuration, :state, :country, :postalCode, :phoneNumber, :token, :latitude,
                  :longitude, :checkinDuration, :tableMode, :image, :promotionalImage, :restaurantMode,
                  :modeConfigured, :updatedAt

    class << self
      def all
        # [new(:id => 1, :userId => 2)]
        conn = Faraday.new('https://alphasandbox.doshii.co', :ssl => {
          :ca_path => "/usr/lib/ssl/certs"
        })
        conn.headers = {'Authorization' => 'Basic MzY5YzI3ZThkODg0ZTBiNTRlNTYwMzViNDFlZWQ0YjA3YjBmYzU5MDkxOTA3NDE4ZjAzNjhhYjY0M2E0YWQzMTpjMGMwNDQxZTliY2M2NzFkZmY5YmViOGUyYTE2ZmI0M2VkMzkyZjhjOWEwMjlkYzgwNzVjYjcxYjFhYzg3ZTVm'}
        response = conn.get('/partner/api/v1/locations')
        # if response.status == 200
        #   locations = JSON.parse(response.body.locations)
        #   locations.map { |attrs| new(attrs) }
        # else
        #   JSON.parse(response.body)
        # end
        # hash.symbolize_keys.slice(*self.attribute_names.map(&:to_sym))
      end
    end

    def initialize(attrs)
      self.attribute_names
      attrs.each { |k, v| self.send("#{k}=", v) }
    end
  end
end
