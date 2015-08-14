module CXML
  class Address
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @iso_country_code = data['isoCountryCode'] || 'US'
        @address_id = data['addressID']
        @name = CXML::Name.new(data['Name'])
        @postal_address = CXML::PostalAddress.new(data['PostalAddress']) if data['PostalAddress']
        @email = CXML::Email.new(data['Email']) if data['Email']
        @phone = CXML::Phone.new(data['Phone']) if data['Phone']
      end
    end

    def render(node)
      node.Address('isoCountryCode' => @iso_country_code, 'addressID' => @address_id) do |t|
        @name.render(t)
        @postal_address.render(t) if @postal_address
        @email.render(t) if @email
        @phone.render(t) if @phone
      end
    end
  end
end
