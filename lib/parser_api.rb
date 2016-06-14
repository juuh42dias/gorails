require 'faraday'
require 'net/http'

class ParserApi

  def initialize(url, method, params)
    @url = url
    @method = method
    @params = params
  end

  def self.get(url)
    get_url = Faraday.get("#{url}")
    get_url.body
    return JSON.parser(get_url.body)
  end

  def post(url)
    # post = Faraday.
  end
end