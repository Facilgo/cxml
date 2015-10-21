module CXML
  class Extrinsic
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @name = data['name']
        @content = data['content']
      end
    end

    def render(node)
      node.Extrinsic('name' => @name) do |t|
        t.text @content
      end
    end
  end
end
