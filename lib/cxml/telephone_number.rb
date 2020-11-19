require 'iso_country_codes'

module CXML
  class TelephoneNumber
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @country_code = data['CountryCode']
        @area_or_city_code = data['AreaOrCityCode']
        @number = data['Number']
        @iso_country_code = IsoCountryCodes.find(@country_code).calling.tr('+', '')
      end
    end

    def render(node)
      node.TelephoneNumber do |t|
        t.CountryCode('isoCountryCode' => @iso_country_code) do |s|
          s.text(@country_code)
        end
        t.AreaOrCityCode  { |s| s.text(@area_or_city_code) }
        t.Number          { |s| s.text(@number) }
      end
    end
  end
end
