module CXML
  class Description
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @xml_lang = data['xml:lang'] || 'en-US'
        @content = data['content']
      end
    end

    def render(node)
      node.Description('xml:lang' => @xml_lang) do |t|
        t.text @content
      end
    end
  end
end
