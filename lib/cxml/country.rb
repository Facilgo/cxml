require 'iso_country_codes'

module CXML
  class Country
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @iso_country_code = data['isoCountryCode']
        @name = IsoCountryCodes.find(@iso_country_code).name
      end
    end

    def render(node)
      node.Country('isoCountryCode' => @iso_country_code) do |t|
        t.text @name
      end
    end
  end
end
