require "net/http"
require "uri"

class Finder
  def initialize(target_url)
    @uri = URI.parse(target_url)
  end
  def request
    http = Net::HTTP.new(@uri.host, @uri.port)
    headers = {}
    response = http.request_head(@uri.request_uri)
    return response.header['x-served-by']
  end
end

class Collator
  def initialize
    @received = []
  end
  def collate(server)
    @received.push(server) if !@received.include? server
  end
  def print
    summary = ""
    @received.sort.each do |r|
      summary += r
      summary += "\n"
    end
  end
end

# Lets this whole file be required by rspec without executing the 'main' body
if __FILE__ == $PROGRAM_NAME then
  if ENV["REQUESTS"].to_i > 0 &&
    ENV["TARGET_URL"] then
    finder = Finder.new ENV["TARGET_URL"]
    collator = Collator.new

    ENV["REQUESTS"].to_i.times do
      collator.collate(finder.request)
    end

    puts collator.print
  end
end
