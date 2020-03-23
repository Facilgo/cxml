require 'cxml/version'
require 'cxml/errors'
require 'time'
require 'nokogiri'

module CXML
  autoload :Protocol,             'cxml/protocol'
  autoload :Document,             'cxml/document'
  autoload :Header,               'cxml/header'
  autoload :Credential,           'cxml/credential'
  autoload :CredentialMac,        'cxml/credential_mac'
  autoload :Sender,               'cxml/sender'
  autoload :Status,               'cxml/status'
  autoload :Request,              'cxml/request'
  autoload :Response,             'cxml/response'
  autoload :Parser,               'cxml/parser'

  autoload :Address,              'cxml/address'
  autoload :BuyerCookie,          'cxml/buyer_cookie'
  autoload :Classification,       'cxml/classification'
  autoload :Country,              'cxml/country'
  autoload :Description,          'cxml/description'
  autoload :Email,                'cxml/email'
  autoload :Extrinsic,            'cxml/extrinsic'
  autoload :ItemOut,              'cxml/item_out'
  autoload :Money,                'cxml/money'
  autoload :Name,                 'cxml/name'
  autoload :OrderRequest,         'cxml/order_request'
  autoload :OrderRequestHeader,   'cxml/order_request_header'
  autoload :Phone,                'cxml/phone'
  autoload :PostalAddress,        'cxml/postal_address'
  autoload :PunchOutSetupRequest, 'cxml/punch_out_steup_request'
  autoload :TelephoneNumber,      'cxml/telephone_number'
  autoload :Url,                  'cxml/url'

  def self.parse(str)
    CXML::Parser.new.parse(str)
  end

  def self.builder
    Nokogiri::XML::Builder.new(:encoding => "UTF-8")
  end
end
