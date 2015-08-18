module CXML
  class PostalAddress
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @name = data['name'] || 'default'
        @deliver_to = data['DeliverTo']
        @street = data['Street']
        @city = data['City']
        @state = data['State']
        @postal_code = data['PostalCode']
        @country = CXML::Country.new(data['Country']) if data['Country']
      end
    end

    def render(node)
      node.PostalAddress('name' => @name) do |t|
        t.DeliverTo   { |s| s.text(@deliver_to) }
        t.Street      { |s| s.text(@street) }
        t.City        { |s| s.text(@city) }
        t.State       { |s| s.text(@state) }
        t.PostalCode  { |s| s.text(@postal_code) }
        @country.render(t) if @country
      end
    end
  end
end
