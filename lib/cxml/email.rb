module CXML
  class Email
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @name = data['name'] || 'default'
        @content = data['content']
      end
    end

    def render(node)
      node.Email('name' => @name) do |t|
        t.text @content
      end
    end
  end
end
