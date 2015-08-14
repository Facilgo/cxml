module CXML
  class Phone
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @name = data['name']

        if data['TelephoneNumber']
          @telephone_number = CXML::TelephoneNumber.new(data['TelephoneNumber'])
        end
      end
    end

    def render(node)
      node.Phone('name' => @name) do |t|
        @telephone_number.render(t) if @telephone_number
      end
    end
  end
end
