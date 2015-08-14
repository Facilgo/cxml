module CXML
  class OrderRequest
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        if data['OrderRequestHeader']
          @order_request_header = CXML::OrderRequestHeader.new(data['OrderRequestHeader'])
        end

        @item_outs = []
        if data['ItemOut'] && data['ItemOut'].is_a?(Array)
          data['ItemOut'].each do |item|
            @item_outs << CXML::ItemOut.new(item)
          end
        end
      end
    end

    def render(node)
      node.OrderRequest do |t|
        @order_request_header.render(t) if @order_request_header

        @item_outs.each do |item_out|
          item_out.render(t)
        end
      end
    end
  end
end
