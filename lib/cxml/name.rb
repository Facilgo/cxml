module CXML
  class Name
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @xml_lang = data['xml:lang'] || 'en'
        @content = data['content']
      end
    end

    def render(node)
      node.Name('xml:lang' => @xml_lang) do |t|
        t.text @content
      end
    end
  end
end
