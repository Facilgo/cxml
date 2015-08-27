module CXML
  class OrderRequestHeader
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @order_date = data['orderDate']
        @order_id = data['orderID']
        @order_version = data['orderVersion'] || '1'
        @order_type = data['orderType'] || 'regular'
        @type = data['type'] || 'new'

        @total = data['Total']
        @ship_to = data['ShipTo']
        @bill_to = data['BillTo']
        @shipping = data['Shipping']
        @tax = data['Tax']
        @contact = data['Contact']
        @comments = data['Comments']
      end
    end

    def render(node)
      node.OrderRequestHeader(
          'orderDate' => @order_date,
          'orderID' => @order_id,
          'orderType' => @order_type,
          'orderVersion' => @order_version,
          'type' => @type) do |n|
        n.Total     { |t| CXML::Money.new(@total['Money']).render(t) }
        n.ShipTo    { |t| CXML::Address.new(@ship_to['Address']).render(t) }
        n.BillTo    { |t| CXML::Address.new(@bill_to['Address']).render(t) }
        n.Shipping  { |t| CXML::Money.new(@shipping['Money']).render(t) }
        n.Tax       { |t| CXML::Money.new(@tax['Money']).render(t) }
        # n.Contact   { |t| puts 'TODO' }
        n.Comments
      end
    end
  end
end
