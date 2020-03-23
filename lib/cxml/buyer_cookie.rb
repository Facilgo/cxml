module CXML
  class BuyerCookie
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @content = data['content']
      end
    end

    def render(node)
      node.BuyerCookie do |t|
        t.text @content
      end
    end
  end
end
