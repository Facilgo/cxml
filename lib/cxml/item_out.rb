module CXML
  class ItemOut
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @quantity = data['quantity']
        @line_number = data['lineNumber']
        @requested_delivery_date = data['requestedDeliveryDate']
        @item_id = data['ItemId']

        @item_detail = data['ItemDetail']
        @unit_price = @item_detail['UnitPrice']
        @unit_of_measure = @item_detail['UnitOfMeasure']

        @shipping = data['Shipping']
      end
    end

    def render(node)
      node.ItemOut('quantity' => @quantity, 'lineNumber' => @line_number, 'requestedDeliveryDate' => @requested_delivery_date) do |t|
        t.ItemID do |o|
          o.SupplierPartID { |p| p.text(@item_id) }
        end
        t.ItemDetail do |o|
          o.UnitPrice { |p| CXML::Money.new(@unit_price).render(p) }
          o.UnitOfMeasure do |p|
            p.text @unit_of_measure['Content']
          end
        end
        t.Shipping do |o|
          o.Money { |p| CXML::Money.new(@shipping['Money']).render(p) }
        end
      end
    end
  end
end
