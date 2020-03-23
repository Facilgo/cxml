module CXML
  class Url
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @content = data['content']
      end
    end

    def render(node)
      node.URL do |t|
        t.text @content
      end
    end
  end
end
