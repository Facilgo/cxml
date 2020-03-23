module CXML
  class PunchOutSetupRequest
    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @operation = data['operation'] || 'create'

        @buyer_cookie = CXML::BuyerCookie.new(data['BuyerCookie'])
        @extrinsic = data['Extrinsic']
        @browser_form_post = data['BrowserFormPost']
        @ship_to = data['ShipTo']
      end
    end

    def render(node)
      node.PunchOutSetupRequest('operation' => @operation) do |n|
        @buyer_cookie.render(n)
        if @extrinsic.present?
          @extrinsic.each do |extrinsic|
            CXML::Extrinsic.new(extrinsic).render(n)
          end
        end
        n.BrowserFormPost do |t|
          CXML::URL.new(@browser_form_post['URL']).render(t)
        end
        n.ShipTo    { |t| CXML::Address.new(@ship_to['Address']).render(t) }
      end
    end
  end
end
