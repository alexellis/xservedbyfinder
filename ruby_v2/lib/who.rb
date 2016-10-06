require 'httparty'

class Who
  include HTTParty

  attr_accessor :result, :url

  def initialize(url)
    @url = url
    @valid_url = is_valid_url?(url)
    get_pi if @valid_url
  end

  def served
    @result.response.header['x-served-by']
  end

  def get_pi
    @result = self.class.get(@url, :verify => false) if @valid_url
  end

  def is_valid_url?(url)
    url =~ /\A#{URI::regexp}\z/
  end
end