# Clients send requests for operations. Only one Request element is allowed for each
# cXML envelope element, which simplifies the server implementations, because no
# demultiplexing needs to occur when reading cXML documents. The Request element
# can contain virtually any type of XML data.

module CXML
  class Request
    attr_accessor :id
    attr_accessor :deployment_mode

    def initialize(data={})
      if data.kind_of?(Hash) && !data.empty?
        @id = data['id']
        @deployment_mode = data['deploymentMode']

        if data['OrderRequest']
          @order_request = CXML::OrderRequest.new(data['OrderRequest'])
        end

        if data['PunchOutSetupRequest']
          @punch_out_setup_request = CXML::OrderRequest.new(data['PunchOutSetupRequest'])
        end
      end
    end

    def render(node)
      node.Request('deploymentMode' => @deployment_mode) do |t|
        @order_request.render(node) if @order_request
        @punch_out_setup_request.render(node) if @punch_out_setup_request
      end
    end
  end
end
