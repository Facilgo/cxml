module CXML
  class Classification
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @domain = data['domain'] || 'UNSPSC'
        @content = data['content']
      end
    end

    def render(node)
      node.Classification('domain' => @domain) do |t|
        t.text @content
      end
    end
  end
end
