module CXML
  class ItemOut
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @quantity = data['quantity']
        @line_number = data['lineNumber']
        @requested_delivery_date = data['requestedDeliveryDate']

        @item_id = data['ItemID']
        @supplier_part_id = @item_id['SupplierPartID']

        @item_detail = data['ItemDetail']
        @unit_price = @item_detail['UnitPrice']
        @description = CXML::Description.new(@item_detail['Description']) if @item_detail['Description']
        @unit_of_measure = @item_detail['UnitOfMeasure']

        @shipping = data['Shipping'] if data['Shipping']
      end
    end

    def render(node)
      node.ItemOut('quantity' => @quantity, 'lineNumber' => @line_number, 'requestedDeliveryDate' => @requested_delivery_date) do |t|
        t.ItemID do |o|
          o.SupplierPartID { |p| p.text(@supplier_part_id['content']) }
        end
        t.ItemDetail do |o|
          o.UnitPrice { |p| CXML::Money.new(@unit_price['Money']).render(p) }
          @description.render(o) if @description
          o.UnitOfMeasure do |p|
            p.text @unit_of_measure['content']
          end
        end
        if @shipping
          t.Shipping do |o|
            o.Money { |p| CXML::Money.new(@shipping['Money']).render(p) }
          end
        end
      end
    end
  end
end
