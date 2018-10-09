require 'benchmark'
require 'net/http'
require 'json'

Event = Struct.new(:name, :date)

puts Benchmark.measure {
  uri = 'http://localhost:4567/events'
  1_000_000.times do
    post = Net::HTTP::Post.new(uri)

    post['Content-Type'] = 'application/json'
    post.body = JSON.generate(Event.new("Ruby unconference", "2018-10-08").to_h)
    response = Net::HTTP.start('localhost', '4567') do |http|
      http.read_timeout = 180
      http.request(post)
    end
  end
}