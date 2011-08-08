require 'httparty'
class GeoLocator
  API_KEY = '29f372bea18f106969d7fe011dfb1b3be9a9e2255e79f532b5cd5944947736cf'
  
  attr_accessor :ip
  
  def initialize(ip)
    @ip = ip
  end
  
  def city
    response[6]
  end
  
  def country_code
    response[4]
  end
  
  def country
    response[5]
  end
  
  def response
    @http_response ||= HTTParty.get('http://api.ipinfodb.com/v3/ip-city', :query => { :key => API_KEY, :ip => @ip })
    @response ||= @http_response.split(';')
    unless @response[0] == "OK"
      raise GeoLocationError
    end
    @response
  end
  
end

class GeoLocationError < StandardError 
end