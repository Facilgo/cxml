module CXML
  class ItemOut
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @quantity = data['quantity']
        @line_number = data['lineNumber']
        @requested_delivery_date = data['requestedDeliveryDate']

        @item_id = data['ItemID']
        @supplier_part_id = @item_id['SupplierPartID']
        @supplier_part_auxiliary_id = @item_id['SupplierPartAuxiliaryID']

        @item_detail = data['ItemDetail']

        if @item_detail
          @unit_price = @item_detail['UnitPrice']
          @classification = CXML::Classification.new(@item_detail['Classification']) if @item_detail['Classification']
          @description = CXML::Description.new(@item_detail['Description']) if @item_detail['Description']
          @unit_of_measure = @item_detail['UnitOfMeasure']
        end

        @shipping = data['Shipping']
        @extrinsic = data['Extrinsic']
      end
    end

    def render(node)
      node.ItemOut('quantity' => @quantity, 'lineNumber' => @line_number, 'requestedDeliveryDate' => @requested_delivery_date) do |t|
        if @supplier_part_id
          t.ItemID do |o|
            o.SupplierPartID { |p| p.text(@supplier_part_id['content']) }
          end
        end
        if @supplier_part_auxiliary_id
          t.ItemID do |o|
            o.SupplierPartAuxiliaryID { |p| p.text(@supplier_part_auxiliary_id['content']) }
          end
        end
        if @item_detail
          t.ItemDetail do |o|
            o.UnitPrice { |p| CXML::Money.new(@unit_price['Money']).render(p) }
            @description.render(o) if @description
            o.UnitOfMeasure do |p|
              p.text @unit_of_measure['content']
            end
            @classification.render(o) if @classification
          end
        end
        if @shipping
          t.Shipping do |o|
            o.Money { |p| CXML::Money.new(@shipping['Money']).render(p) }
          end
        end
        if @extrinsic.present?
          @extrinsic.each do |extrinsic|
            CXML::Extrinsic.new(extrinsic).render(t)
          end
        end
      end
    end
  end
end
